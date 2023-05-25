library(DBI)
library(RPostgres)
source("con.R")

# Function to display menu items
displayMenu <- function() {
  query <- "SELECT Item_id, Item_name, Item_price FROM Menu"
  menu_items <- dbGetQuery(con, query)
  cat(sprintf("%-10s%-30s%-10s\n", "Item ID", "Item Name", "Price"))
  
  cat("Food Menu:\n")
  print(menu_items)
}

# Function to view an order by order ID
view_order <- function() {
  while (TRUE) {
    # Prompt the user to enter the order ID
    order_id <- readline(prompt = "Enter the Order ID to view (or 'q' to quit): ")
    
    # Check if the user wants to quit
    if (tolower(order_id) == "q") {
      break
    }
    
    # Construct the SELECT query
    select_query <- paste0("SELECT * FROM final_orders WHERE Order_id = ", order_id)
    
    # Execute the SELECT query
    order_data <- dbGetQuery(con, select_query)
    
    # Check if any rows were returned
    if (nrow(order_data) > 0) {
      # Order found, print the order details
      print(order_data)
    } else {
      # Order not found, print error message
      cat("Error: Order not found.\n")
    }
    
    # Ask the user if they want to view another order or add an order
    while (TRUE) {
      choice <- readline(prompt = "Do you want to view another order (V) or add an order (A)? (V/A): ")
      if (tolower(choice) %in% c("v", "a")) {
        break
      }
      cat("Invalid choice. Please enter 'V' or 'A'.\n")
    }
    
    if (tolower(choice) == "v") {
      next  # Continue to view another order
    } else {
      add_order()  # Call the add_order function
      break  # Exit the loop after adding an order
    }
  }
  
  # Ask the user if they want to go back to the main menu
  while (TRUE) {
    back_to_menu <- readline(prompt = "Do you want to go back to the main menu? (Y/N): ")
    if (tolower(back_to_menu) %in% c("y", "n")) {
      break

       # Display the menu
       displayMenu()
    }
    cat("Invalid choice. Please enter 'Y' or 'N'.\n")

  }
  
  if (tolower(back_to_menu) == "n") {
    processOrder()  # Assuming processOrder() is defined somewhere
  }
}

# Function to add an order
add_order <- function() {
  # Code to add an order
}

# Call the view_order function
view_order()

# Close the database connection
dbDisconnect(con)

# Function to go back to the main menu
processOrder <- function() {
  # Code to go back to the main menu
}
