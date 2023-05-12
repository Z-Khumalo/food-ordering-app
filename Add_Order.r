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

# get the highest order_id from the Orders table
  query_max_order_id <- paste("SELECT MAX(Order_id) FROM Final_Orders")
  max_order_id <- dbGetQuery(con, query_max_order_id)[1,1]
  
  # if Orders table is empty, set max_order_id to 0
  if(is.na(max_order_id)) {
    max_order_id <- 0
  }
  
  # generate new order_id by incrementing the max_order_id
  order_id <- max_order_id + 1
  
  # initialize order_total and order_quantity to 0
  order_total <- 0
  order_quantity <- 0
  
  # initialize empty list to store order items
#   order_items <- list()

  # Display the menu
  displayMenu()

    order_data <- data.frame(Order_id = integer(),
                            Order_quantity = integer(),
                            Order_date = character(),
                            Order_total = character(),
                             Item_id = integer(),
                            
                            Admin_id = integer(),                
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

       get_admin <- paste0("SELECT Admin_id FROM Administrator WHERE Admin_user_name='", creds$username, "'")
        admin_id <- dbGetQuery(con,get_admin)$Admin_id 

    # add item and quantity to order_items
    # item_name <- menu$Item_name[menu$Item_id == as.integer(item_id)]
    # item_price <- menu$Item_price[menu$Item_id == as.integer(item_id)]
    # order_items[[length(order_items) + 1]] <- list(item_id = item_id, item_name = item_name, quantity = as.integer(quantity), price = item_price)
    
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
        # Grand_total <- Grand_total + total_price
    
     
        # order_items[[length(order_items) + 1]] <- list(item_id = item_id, item_name = item_name, quantity = as.integer(quantity), price = item_price,Grand_total)

    
    # Add the item to the order data frame
        order_data <- rbind(order_data, data.frame(order_id,
                            Order_quantity = as.integer(quantity),
                            Item_total = as.character(total_price),
                            Order_date = as.character(order_date),
                             Item_id = as.integer(item_id),
                             Admin_id = NA,
                             Item_name = as.character((item_name)
                             )))

    
    # Prompt the user to add another item2

    add_another <- readline(prompt = "Do you want to add another item to your order? (Y/N): ")
    if (tolower(add_another) != "y") {
      break
    }

  }


# getAdmin_id <- function(){
#         get_admin <- paste0("SELECT Admin_id FROM Administrator WHERE Admin_user_name=", creds$username)
#         admin_id <- dbGetQuery(con,get_admin)$Admin_id

#         return(admin_id)
#     }
#     # Print the order data
    cat("THANK YOU FOR YOUR ORDER!\n Order summary:\n")
    cat(sprintf("Order ID: %d\n", order_id))
    print(order_data)
    # cat(sprintf("GRAND TOTAL: %d\n", Grand_total))
  
    
#    dbWriteTable(con, "Final_Orders", order_data, append = TRUE, row.names = FALSE)

}


  # Save the order data to the database
  
print(processOrder())

     ##process needs to take the user back the main menu after order has been processed