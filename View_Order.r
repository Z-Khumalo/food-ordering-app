library(DBI)
library(RPostgres)
source("con.R")

#Function to view an order by order ID
view_order <- function() {
  while (TRUE) {
    # Prompt the user to enter the order ID
    order_id <- readline(prompt = "Enter the Order ID to view (or 'q' to quit): ")

#Check if the user wants to quit
    if (tolower(order_id) == "q") {
      break
    }

#Construct the SELECT query
    select_query <- paste0("SELECT * FROM final_orders WHERE Order_id = ", order_id)

#Execute the SELECT query
    order_data <- dbGetQuery(con, select_query)

#Check if any rows were returned
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
      break
    }
  }
}

#Call the view_order function
view_order()
