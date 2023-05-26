# Load necessary packages
library(DBI)
library(RPostgreSQL)
source("con.R")

# Function to delete orders
delete_orders <- function() {
  # Get the Order_id to delete from the user
  order_id_to_delete <- readline(prompt = "Enter the Order_id to delete: ")
  
  # Construct the DELETE statement
  delete_query <- paste0("DELETE FROM final_orders WHERE order_id = '", order_id_to_delete, "'")
  
  # Execute the DELETE statement
  result <- dbExecute(con, delete_query)
  
  # Check if any rows were affected
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
  }
}

# Call the delete_orders function
delete_orders()
