

#Load necessary packages
library(DBI)
library(RPostgreSQL)
source("con.R")



# Get the order ID from the user
order_id <- readline("Enter the order ID to delete: ")

# Define the DELETE query
delete_query <- paste("DELETE FROM orders WHERE order_id = ", order_id)

# Execute the DELETE query
result <- dbExecute(con, delete_query)

# Check if any rows were affected
if (result == 1) {
  # Successful delete, print message
  print("Order deleted successfully.")
} else {
  # No rows affected, print error message
  print("Error: Order not found.")
}
