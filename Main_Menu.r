# Load the required packages
library(DBI)
library(RPostgreSQL)
source("con.R")

#######################################login#####################################
# Function to prompt user for login credentials
login_func <- function() {
  username <- readline("Enter your username: ")
  password <- readline("Enter your password: ")
  return(list(username=username, password=password))
}


# Loop until user provides valid credentials or chooses to exit
while (TRUE) {
  # Prompt user for login credentials
  creds <- login_func()
  
  
  # Construct SQL query to check credentials against database
  sql <- paste0("SELECT * FROM Administrator WHERE Admin_name = '",
                creds$username, "' AND Admin_password = '", creds$password, "'")
  
  
  
  # Execute query and check number of rows returned
  res <- dbGetQuery(con, sql)
  if (nrow(res) == 1) {
    # Successful login, grant access to resources
    print("Login successful!")
    mainMenu()
    break
  } else {
    # Failed login, ask user if they want to try again or exit
    choice <- readline("Invalid username or password. Enter 'r' to try again or 'q' to quit: ")
    if (choice == "q") {
      break
    }
  }
  
  #############################################################################
  
  
  #####################Delete Orders##################################
  # Function to delete orders
  delete_Orders <- function() {
    # Get the Order_id to delete from the user
    order_id_to_delete <- readline(prompt = "Enter the Order_id to delete: ")
    
    #Construct the DELETE statement
    delete_query <- paste0("DELETE FROM final_orders WHERE order_id = '", order_id_to_delete, "'")
    
    #Execute the DELETE statement
    result <- dbExecute(con, delete_query)
    
    #Check if any rows were affected
    if (result >= 1) {
      # Successful delete, print message
      print("Order deleted successfully.")
    } else {
      # Failed delete, ask user if they want to try again or exit
      choice <- readline("Error: Order not found. Enter 'r' to try again or 'q' to quit: ")
      if (choice == "q") {
        return()
      } else if (choice == "r") {
        # Recursive call to delete_orders function to try again
        delete_orders()
      }
      #Back to menu
      
      back_to <- readline(prompt = "Do you want to go back to the main menu? (Y/N): ")
      if (tolower(back_to) == "y") {
        mainMenu()
        
      }
      else if (tolower(back_to) == "n"){
        delete_Orders()
      }
      else {
        cat("Invalid choice. Please enter a valid choice.\n")
        next
      }
    }
  }
  
  ###################################################################
  
  #################################track sales#############################
  track_Sales <- function(){
    # Establish connection to database
 
    # Construct SQL query to track the sales
    sql <- paste("SELECT Item_category, Item_name, sum(Order_quantity) as Quantity_Sold, sum(Order_total) AS total_sales
                FROM final_orders
                GROUP BY Item_category,Item_name")
    
    
    #Execute query and store results in a data frame
    result <- dbGetQuery(con, sql)
    
    # Return result
    print(result)
    mainMenu()
  }
  
  #######################################################################
  
  ###############################view order###############################
  view_Orders <- function() {
    while (TRUE) {
      # Prompt the user to enter the order ID
      order_id <- readline(prompt = "Enter the Order ID to view (or 'q' to quit): ")
      
      #  Check if the user wants to quit
      if (tolower(order_id) == "q") {
        break
      }
      
      #  Construct the SELECT query
      select_query <- paste0("SELECT * FROM final_orders WHERE order_id = ", order_id)
      
      #  Execute the SELECT query
      order_data <- dbGetQuery(con, select_query)

      
      # Check if any rows were returned
      if (nrow(order_data) > 0) {
        # Order found, print the order details
        print(order_data)
      } else {
        # Order not found, print error message
        cat("Error: Order not found.\n")
      }
      
      #Ask the user if they want to view another order
      repeat {
        choice <- readline(prompt = "Do you want to view another order? (Y/N): ")
        if (tolower(choice) %in% c("y", "n")) {
          break
        }
        cat("Invalid choice. Please enter 'Y' or 'N'.\n")
      }
      
      if (tolower(choice) == "n") {
        mainMenu()
        break
      }
      
    }
  }
  
  ########################################################################
  
  #########################################dispaly food menu###############################
  # Function to display menu items
  displayMenu <- function() {
    query <- "SELECT Item_id, Item_name, Item_price FROM Menu"
    menu_items <- dbGetQuery(con, query)
    cat(sprintf("%-10s%-30s%-10s\n", "Item ID", "Item Name", "Price"))
    
    cat("Food Menu:\n")
    print(menu_items)
  }
  ####################################################################################
  
  #######################Process order###############################
  
  # Function to process the order
  processOrder <- function() {
    
    # initialize order_total and order_quantity to 0
    order_total <- 0
    order_quantity <- 0
    
    
    # Display the menu
    displayMenu()
    
    order_id <- dbGetQuery(con, "SELECT nextval('SQ_OrderID')")[1, 1]
    
    
    order_data <- data.frame(order_id = integer(),
                             order_quantity = integer(),
                             order_date = character(),
                             order_total = double(),
                             item_id = integer(),
                             item_price  = double(),
                             item_category = character(),               
                             item_name = character(), 
                             admin_name = character(),
                             
                             stringsAsFactors = FALSE)
    
    
    # Start a loop to allow the user to add items to the order
    repeat {
      # Prompt the user to enter the item ID
      item_id <- readline(prompt = "Enter the Item ID you wish to add to your order (or type 0 to finish): ")
      
      
      # Check if the user wants to finish the order
      if (item_id == "0") {
        break
      }
      
      # Check if the item ID is a valid integer
      if (!grepl("^\\d+$", item_id)) {
        cat("Invalid Item ID. Please enter a valid Item ID.\n")
        next
      }
      
      item_exists <- as.integer(item_id)
      
      # Check if the item ID exists in the menu
      query <- paste0("SELECT Item_id, Item_name, Item_price FROM Menu WHERE Item_id = ", item_id)
      item_exists <- dbGetQuery(con,query)
      
      if (nrow(item_exists) ==0) { 
        cat("Invalid Item ID. Please enter a valid Item ID from the Menu List.\n")
        next
      }
      
      quantity <- as.integer(readline(prompt = "Enter the quantity for this item: "))
      if (is.na(quantity) || quantity <= 0) {
        cat("Invalid quantity. Please enter a positive integer.\n")
        next
      }
      
      admin_name <- creds$username
      
      
      # Get the current date and time
      order_date <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
      
      # Calculate the total price for the item
      get_price_query <- paste0("SELECT * FROM Menu WHERE Item_id=", item_id)
      
      
      item_price_result <- dbGetQuery(con,get_price_query)
      if (nrow(item_price_result) == 0) {
        cat("Error: Item ID not found in menu.\n")
        next
      }
      item_price <- item_price_result$item_price[1]
      item_name <- item_price_result$item_name[1]
      total_price <- item_price * quantity
      item_category <- item_price_result$item_category
      
      
      # Add the item to the order data frame
      order_data <- rbind(order_data, data.frame(order_id,
                                                 order_quantity = as.integer(quantity),
                                                 order_total = as.double(total_price),
                                                 order_date = as.character(order_date),
                                                 item_id = as.integer(item_id),
                                                 item_price = as.double(item_price),
                                                 item_category = as.character(item_category),
                                                 item_name = as.character(item_name),
                                                 admin_name = as.character(admin_name)))
      
      
      
      
      # Commit the changes
      #dbCommit(con)
      add_another <- readline(prompt = "Do you want to add another item to your order? (Y/N): ")
      if (tolower(add_another) != "y") {
        
        break
        
      }
    }
    
    # Specify the source column when using dbWriteTable()
    dbWriteTable(con, "final_orders", order_data, append = TRUE, row.names = FALSE)
    #     # Print the order data
    cat("THANK YOU FOR YOUR ORDER!\n Order summary:\n")
    cat(sprintf("Order ID: %d\n", order_id))
    print(order_data)
    
    
    back_to <- readline(prompt = "Do you want to go back to the main menu? (Y/N): ")
    if (tolower(back_to) == "y") {
      mainMenu()
      
    }
    else if (tolower(back_to) == "n"){
      processOrder()
    }
    else {
      cat("Invalid choice. Please enter a valid choice.\n")
      next
    }
    
  }
  
}

#################################Main menu##################################

# Function to display the main menu
mainMenu <- function() {
  cat("\nMain Menu:\n")
  cat("1. Add new Order\n")
  cat("2. Update Order\n")
  cat("3. Delete Order\n")
  cat("4. View/Track Orders\n")
  cat("5. View/Track Sales\n")
  cat("6. Exit\n")
  
  choice <- readline(prompt = "Enter your choice (1-6): ")
  
  if (choice == "1") {
    processOrder()
  } 
  else if (choice == "2") {
    UpdateProcess()
  }
  else if (choice == "3") {
    delete_Orders()
  }
  else if (choice == "4") {
    view_Orders()
  }
  else if (choice == "5") {
    track_Sales()
  }
  else if (choice == "6") {
    cat("Exiting...\n")
    dbDisconnect(con)
    return()
  } 
  else {
    cat("Invalid choice. Please enter a valid choice.\n")
    mainMenu()
  }
}

###########################################################################################

print(login_func())
# Save the order data to the database
