# Load the required packages
library(DBI)
library(RPostgreSQL)
source("con.R")
source("Admin_Login.r")

# Function to display menu items
displayMenu <- function() {
  query <- "SELECT Item_id, Item_name, Item_price FROM Menu"
  menu_items <- dbGetQuery(con, query)
  cat(sprintf("%-10s%-30s%-10s\n", "Item ID", "Item Name", "Price"))
  
  cat("Food Menu:\n")
  print(menu_items)
}


# Function to process the order
processOrder <- function(admin_id) {
  
  
  
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
                                               admin_name = as.character(admin_name)
                                               ))
    
  

      
      
      # Commit the changes
    dbCommit(con)
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

  
  #back to mainmenu
  
  
  back_to_menu <- readline(prompt = "Do you want to go back to the main menu? (Y/N): ")
  if (tolower(add_another) != "y") {
    processOrder()
    next
  }
  
}


# Save the order data to the database

print(processOrder())

##process needs to take the user back the main menu after order has been processed

  
  
#   # Construct SQL query to check credentials against database
#   sql <- paste0("SELECT * FROM Administrator WHERE Admin_user_name = '",
#                 creds$username, "' AND Admin_password = '", creds$password, "'")
  
  
  
#   # Execute query and check number of rows returned
#   res <- dbGetQuery(con, sql)
#   if (nrow(res) == 1) {
#     # Successful login, grant access to resources
#     print("Login successful!")
#     break
#   } else {
#     # Failed login, ask user if they want to try again or exit
#     choice <- readline("Invalid username or password. Enter 'r' to try again or 'q' to quit: ")
#     if (choice == "q") {
#       break
#     }
#   }
# }

############################################################################################################





# Function to display menu items
displayMenu <- function() {
  query <- "SELECT Item_id, Item_name, Item_price FROM Menu"
  menu_items <- dbGetQuery(con, query)
  cat(sprintf("%-10s%-30s%-10s\n", "Item ID", "Item Name", "Price"))
  
  cat("Food Menu:\n")
  print(menu_items)
}


# Function to process the order
processOrder <- function(admin_id) {
  
  
  
  # initialize order_total and order_quantity to 0
  order_total <- 0
  order_quantity <- 0
  
  
  # Display the menu
  displayMenu()

  order_id <- dbGetQuery(con, "SELECT nextval('SQ_OrderID')")[1, 1]
 
  
  order_data <- data.frame(order_id = integer(),
                           Order_quantity = integer(),
                           Order_date = character(),
                           Order_total = character(),
                           Item_id = integer(),
                           Selling_price  = integer(),
                           Admin_name = character(),               
                           Item_name = character(), 
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
    get_price_query <- paste0("SELECT Item_price, Item_name FROM Menu WHERE Item_id=", item_id)
    
    
    item_price_result <- dbGetQuery(con,get_price_query)
    if (nrow(item_price_result) == 0) {
      cat("Error: Item ID not found in menu.\n")
      next
    }
    item_price <- item_price_result$item_price[1]
    item_name <- item_price_result$item_name[1]
    total_price <- item_price * quantity
    
    
    # Add the item to the order data frame
    order_data <- rbind(order_data, data.frame(order_id,
                                               Order_quantity = as.integer(quantity),
                                               Item_total = as.character(total_price),
                                               Order_date = as.character(order_date),
                                               Item_id = as.integer(item_id),
                                                Selling_price = item_price,
                                               Admin_name = admin_name,
                                               Item_name = as.character((item_name)
                                               )))
    
  
sql <- paste0("INSERT INTO Orders (Order_id, Order_quantity, Order_date, Item_total,Item_id, Item_name,Selling_price,Admin_user_name ) VALUES ('",order_data$order_id, "', '", order_data$Order_quantity, "', '",order_data$Order_date, "', '",order_data$Item_total, "', '",order_data$Item_id, "',' ",order_data$Item_name, "',' ",order_data$Selling_price, "',' " ,order_data$Admin_name, "')")    
      
dbGetQuery(con,sql)
      
      
      # Commit the changes
      dbCommit(con)
    add_another <- readline(prompt = "Do you want to add another item to your order? (Y/N): ")
    if (tolower(add_another) != "y") {
      
      break
      
    }
   
  }
  
  
  #     # Print the order data
  cat("THANK YOU FOR YOUR ORDER!\n Order summary:\n")
  cat(sprintf("Order ID: %d\n", order_id))
  print(order_data)
  # dbWriteTable(con, "Orders", order_data, append = TRUE, row.names = False)
  
  #back to mainmenu
  
  
  back_to_menu <- readline(prompt = "Do you want to go back to the main menu? (Y/N): ")
  if (tolower(add_another) != "y") {
    processOrder()
    next
  }
  
}


# Save the order data to the database

print(processOrder())

##process needs to take the user back the main menu after order has been processed
