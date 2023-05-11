# Load the required packages
library(DBI)
library(RPostgreSQL)
source("con.R")



# Function to display menu items
displayMenu <- function() {
  query <- "SELECT Item_id, Item_name, Item_price FROM Menu"
  menu_items <- dbGetQuery(con, query)
  cat("Food Menu:\n")
  print(menu_items)
}

# Function to process the order
processOrder <- function(admin_id) {
  # Display the menu
  displayMenu()

    order_data <- data.frame(Order_id = integer(),
                             Item_id = integer(),
                            Item_name = character(), 
                            Order_quantity = integer(),                  
                            Order_date = character(),
                            Order_total = character(),

                            # Admin_id = integer(),
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
    
    item_id <- as.integer(item_id)
    
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

    
    # Get the current date and time
    order_date <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
    
    # Calculate the total price for the item
        get_price_query <- paste0("SELECT Item_price, Item_name FROM Menu WHERE Item_id=", item_id)
        item_price <- dbGetQuery(con,get_price_query)$item_price
        item_name <- dbGetQuery(con,get_price_query)$item_name
        total_price <- item_price * quantity
    
    # Add the item to the order data frame
        order_data <- rbind(order_data, data.frame(Order_Id = NA,
                            Order_quantity = as.character(quantity),
                            Order_total = as.character(total_price),
                            Order_date = as.character(order_date),
                             Item_id = as.integer(item_id),
                             admin_id = NA,
                             Item_name = as.character((item_name)
                             )))

    
                # Prompt the user to add another item
    add_another <- readline(prompt = "Do you want to add another item to your order? (Y/N): ")
    if (tolower(add_another) != "y") {
      break
    }

  }
    # Print the order data
    cat("THANK YOU FOR YOUR ORDER!\n Order summary:\n")
     print(order_data)
    
   dbWriteTable(con, "Final_Orders", order_data, append = TRUE, row.names = FALSE)

}


  # Save the order data to the database
  
     print(processOrder())

     ##process needs to take the user back the main menu after order has been processed