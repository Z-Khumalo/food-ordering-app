library(shiny)
library(DBI)
library(RPostgreSQL)
source("con.R")


# Define the UI
# UI
ui <- fluidPage(
  titlePanel("Food Ordering App"),
  sidebarLayout(
    sidebarPanel(
      textInput("username", "Username:"),
      passwordInput("password", "Password:"),
      actionButton("login", "Login")
      
    ),
    
    mainPanel(
      conditionalPanel(
        condition = "!input.login",
        h4("Please login to access the system.")
      ),
      conditionalPanel(
        condition = "input.login == 1",
        tableOutput("orderTableDetails"),
        tabsetPanel(
          id = "main_tabs",
          tabPanel("Add Order",
                   h4("ADD ORDER"),
                   textInput("itemIdInput", "Item ID"),
      numericInput("quantityInput", "Quantity:", value = 1, min = 1),
      dataTableOutput("order_data"),
      actionButton("addToOrderBtn", "Add to Order"),
      
                   actionButton("finishOrderBtn", "Submit Order"),
                    verbatimTextOutput("orderSummary"),
                    
                    tableOutput("menuTable")),

          tabPanel("Update Order",
        textInput("updateItemIdInput", "Item ID to Update:"),
      numericInput("updateQuantityInput", "New Quantity:", value = 1, min = 1),
      actionButton("updateQuantityBtn", "Update Quantity"),
                  ),

          tabPanel("Delete Order",
                   h4("Delete Order"),
                         
      textInput("deleteItemIdInput", "Item ID to Delete:"),
      actionButton("deleteItemBtn", "Delete Item"),
      actionButton("deleteOrderBtn", "Delete Whole Order")
                   
          ),

          tabPanel("View/Track Orders", 
          h4("View Orders"),
          textInput("orderIdInput", "Order ID:"),
          actionButton("viewOrderBtn", "View Order"),

          tableOutput("order_items"),
          actionButton("finishOrderBtn", "Finish Order"),
      ),

          tabPanel("View/Track Sales",tableOutput("salesTable"),
                    dateInput("salesDateInput", "Sales Date:")
                  
          )
        )
      )
    )
  )
)



# Define the server
server <- function(input, output, session) {

  # Track the login status
  loggedIn <- reactiveVal(FALSE)
  
  # Login function
  observeEvent(input$login, {
    username <- isolate(input$username)
    password <- isolate(input$password)
    
    # Construct SQL query to check credentials against the database
    sql <- paste0("SELECT * FROM Administrator WHERE Admin_name = '",
                  username, "' AND Admin_password = '", password, "'")
    
    res <- dbGetQuery(con, sql)
    
    if (nrow(res) != 1) {
      # Failed login
      showModal(modalDialog(
        title = "Login failed",
        "Login unsuccessful.",
        footer = modalButton("OK", onclick = "$('#login').hide();")
      ))
    } else {
      # Successful login
      loggedIn(TRUE)
      showModal(modalDialog(
        title = "Login Successful",
        "You have successfully logged in.",
        footer = modalButton("OK")
      ))
    }
  })

  # Create reactive values to store the order details
  order_data <- reactiveValues(
    items = data.frame(
      order_id = integer(),
      order_quantity = integer(),
      order_date = character(),
      order_total = double(),
      item_id = integer(),
      item_price = double(),
      item_category = character(),
      item_name = character(),
      admin_name = character(),
      stringsAsFactors = FALSE
    ),
    current_order_id = 0
  )

  # Display the food menu table
  output$menuTable <- renderTable({
    query <- "SELECT Item_id, Item_name, Item_price FROM Menu"
    menu_items <- dbGetQuery(con, query)
    menu_items
  })

  # Add item to the order
  observeEvent(input$addToOrderBtn, {
    item_id <- input$itemIdInput
    quantity <- input$quantityInput

    if (item_id == "0") {
      return()
    }

    if (!grepl("^\\d+$", item_id)) {
      cat("Invalid Item ID. Please enter a valid Item ID.\n")
      return()
    }

    item_exists <- dbGetQuery(con, paste0("SELECT Item_id, Item_name, Item_price FROM Menu WHERE Item_id = ", item_id))

    if (nrow(item_exists) == 0) {
      cat("Invalid Item ID. Please enter a valid Item ID from the Menu List.\n")
      return()
    }

    if (is.na(quantity) || quantity <= 0) {
      cat("Invalid quantity. Please enter a positive integer.\n")
      return()
    }

    admin_name <-isolate(input$username)
    order_date <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")

    get_price_query <- paste0("SELECT * FROM Menu WHERE Item_id=", item_id)
    item_price_result <- dbGetQuery(con, get_price_query)

    if (nrow(item_price_result) == 0) {
      cat("Error: Item ID not found in menu.\n")
      return()
    }

    item_price <- item_price_result$item_price[1]
    item_name <- item_price_result$item_name[1]
    total_price <- item_price * quantity
    item_category <- item_price_result$item_category

    if (order_data$current_order_id == 0) {
      # Generate a new order ID
      order_id <- dbGetQuery(con, "SELECT nextval('SQ_OrderID')")[1, 1]
      order_data$current_order_id <- order_id
    } else {
      # Use the current order ID
      order_id <- order_data$current_order_id
    }

    new_item <- data.frame(
      order_id = order_id,
      order_quantity = as.integer(quantity),
      order_total = as.double(total_price),
      order_date = as.character(order_date),
      item_id = as.integer(item_id),
      item_price = as.double(item_price),
      item_category = as.character(item_category),
      item_name = as.character(item_name),
      admin_name = as.character(admin_name),
      stringsAsFactors = FALSE
    )

    # Append the new item to the order_data
    order_data$items <- rbind(order_data$items, new_item)

    # Update the database table with the new item
    dbWriteTable(con, "final_orders", new_item, append = TRUE, row.names = FALSE)

      updateTextInput(session, "itemIdInput", value = "")
      updateNumericInput(session, "quantityInput", value = 1)
  })

  # Finish the order
  observeEvent(input$finishOrderBtn, {
    if (order_data$current_order_id == 0) {
      cat("No current order. Please add items to the order before finishing.\n")
      return()
    }

    # Perform any necessary actions for finishing the order
        showModal(modalDialog(
        title = "Order placed.",
        "Order finished successfully!",
        footer = modalButton("OK")
      ))


    # Reset the current order ID
    order_data$current_order_id <- 0

    # Clear the order items
    order_data$items <- data.frame(
      order_id = integer(),
      order_quantity = integer(),
      order_date = character(),
      order_total = double(),
      item_id = integer(),
      item_price = double(),
      item_category = character(),
      item_name = character(),
      admin_name = character(),
      stringsAsFactors = FALSE
    )
  })

  # View order details
  observeEvent(input$viewOrderBtn, {
    order_id <- input$orderIdInput

    if (is.na(order_id) || order_id == "" || !grepl("^\\d+$", order_id)) {
      cat("Invalid Order ID. Please enter a valid Order ID.\n")
      return()
    }

    query <- paste0("SELECT * FROM final_orders WHERE order_id = ", order_id)
    order_items <- dbGetQuery(con, query)

    if (nrow(order_items) == 0) {
      cat("Order ID not found.\n")
      return()
    }

    order_data$items <- order_items
  })

  # Update item quantity
  observeEvent(input$updateQuantityBtn, {
    item_id <- input$updateItemIdInput
    quantity <- input$updateQuantityInput

    if (is.na(item_id) || item_id == "" || !grepl("^\\d+$", item_id)) {
      cat("Invalid Item ID. Please enter a valid Item ID.\n")
      return()
    }

    if (is.na(quantity) || quantity <= 0) {
      cat("Invalid quantity. Please enter a positive integer.\n")
      return()
    }

    item_index <- which(order_data$items$item_id == as.integer(item_id))

    if (length(item_index) == 0) {
      cat("Item ID not found in the order.\n")
      return()
    }

    order_data$items$order_quantity[item_index] <- as.integer(quantity)
    order_data$items$order_total[item_index] <- as.double(quantity * order_data$items$item_price[item_index])

    dbExecute(con, paste0("UPDATE final_orders SET order_quantity = ", quantity, ", order_total = ", quantity * order_data$items$item_price[item_index], " WHERE order_id = ", order_data$current_order_id, " AND item_id = ", item_id))
  })

  # Cancel item
  observeEvent(input$cancelItemBtn, {
    item_id <- input$cancelItemIdInput

    if (is.na(item_id) || item_id == "" || !grepl("^\\d+$", item_id)) {
      cat("Invalid Item ID. Please enter a valid Item ID.\n")
      return()
    }

    item_index <- which(order_data$items$item_id == as.integer(item_id))

    if (length(item_index) == 0) {
      cat("Item ID not found in the order.\n")
      return()
    }

    order_data$items <- order_data$items[-item_index, ]

    dbExecute(con, paste0("DELETE FROM final_orders WHERE order_id = ", order_data$current_order_id, " AND item_id = ", item_id))
          showModal(modalDialog(
        title = "Item removed from order.",
        "Item removed successfully!",
        footer = modalButton("OK")
      ))


  })

  # Delete item
  observeEvent(input$deleteItemBtn, {
    item_id <- input$deleteItemIdInput

    if (is.na(item_id) || item_id == "" || !grepl("^\\d+$", item_id)) {
      cat("Invalid Item ID. Please enter a valid Item ID.\n")
      return()
    }

    item_index <- which(order_data$items$item_id == as.integer(item_id))

    if (length(item_index) == 0) {
      cat("Item ID not found in the order.\n")
      return()
    }

    order_data$items <- order_data$items[-item_index, ]

    dbExecute(con, paste0("DELETE FROM final_orders WHERE order_id = ", order_data$current_order_id, " AND item_id = ", item_id))
  })

  # Delete whole order
  observeEvent(input$deleteOrderBtn, {
    if (order_data$current_order_id == 0) {
      cat("No current order to delete.\n")
      return()
    }

    dbExecute(con, paste0("DELETE FROM final_orders WHERE order_id = ", order_data$current_order_id))

    order_data$current_order_id <- 0

    order_data$items <- data.frame(
      order_id = integer(),
      order_quantity = integer(),
      order_date = character(),
      order_total = double(),
      item_id = integer(),
      item_price = double(),
      item_category = character(),
      item_name = character(),
      admin_name = character(),
      stringsAsFactors = FALSE
    )

    cat("Order deleted successfully.\n")
  })

  # Display the order details table
  output$orderTableDetails <- renderTable({
    order_data$items
  })

  output$order_info <- renderDataTable({
    # Query the food menu from the database
    order_info <- dbGetQuery(con, "SELECT * FROM final_orders")
    order_info
  })


# Display the order summary
output$orderSummary <- renderPrint({
  order_id <- order_data$current_order_id

  if (order_id == 0) {
    cat("No current order.\n")
    return()
  }

  cat("Order ID: ", order_id, "\n")

  # Calculate the total price by summing the order_total column
  order_total <- sum(order_data$items$order_total)
  cat("Total Price: R", order_total, "\n")
})
# # Track sales by date
#   output$salesTable <- renderTable({
#     sales_date <- input$salesDateInput
#     query <- paste0("SELECT order_id, order_date, order_total FROM final_orders WHERE DATE(order_date) = '", sales_date, "'")
#     sales_data <- dbGetQuery(con, query)
#     sales_data
#   })

# Track sales by date
output$salesTable <- renderTable({
  sales_date <- input$salesDateInput

  # Return an empty table if no date is selected
  if (is.null(sales_date)) {
    return(NULL)
  }

  query <- paste0("SELECT b.Item_category, b.Item_name, sum(cast(a.Order_quantity as integer)) as Quantity_Sold, sum(cast(a.Order_total as decimal)) AS total_sales
                FROM final_orders a LEFT JOIN Menu b ON a.Item_id = b.Item_id
                WHERE DATE(order_date) = '", sales_date, "'
                GROUP BY b.Item_category,b.Item_name
                ")
  sales_data <- dbGetQuery(con, query)
  sales_data
})
}

# Run the Shiny app
runApp(shinyApp(ui = ui, server = server))
