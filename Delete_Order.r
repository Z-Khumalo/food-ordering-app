
#Load necessary packages
library(DBI)
library(RPostgreSQL)
source("con.R")

# Function to delete orders
delete_orders <- function() {
order_id_to_delete <- readline(prompt = "Enter the Order_id to delete: ")

# Construct the DELETE statement
delete_query <- paste0("DELETE FROM Orders WHERE Order_id = '", order_id_to_delete, "'")

# Execute the DELETE statement
dbExecute(con, delete_query)
  # Check if any rows were affected
  if (delete_query >= 1) {
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
print(delete_orders())
