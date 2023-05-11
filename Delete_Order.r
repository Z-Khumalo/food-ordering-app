

#Load necessary packages
library(DBI)
library(RPostgreSQL)
source("con.R")

# Function to delete orders
delete_orders <- function() {
  order_id <- readline("Enter the order ID to delete: ")

  return(list(order_id = order_id))
}
# Loop 
while (TRUE) {
  # Prompt admin for order ID to delete
  orderss <- delete_orders()

  # Define the DELETE query
  delete_query <- paste("DELETE FROM orders WHERE order_id = ", orderss$order_id)

  # Execute the DELETE query
  result <- dbExecute(con, delete_query)

  # Check if any rows were affected
  if (result == 1) {
    # Successful delete, print message
    print("Order deleted successfully.")
    break
  } else {
    # Failed delete, ask admin if they want to try again or exit
    choice <- readline("Error: Order not found. Enter 'r' to try again or 'q' to quit: ")
    if (choice == "q") {
      break
    }
  }
}
