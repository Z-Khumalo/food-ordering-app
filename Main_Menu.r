library(DBI)
library(RPostgreSQL)
# source("con.R")
source("Admin_Login.r")
source("Add_Order.r")
source("Deleter.r")
source("Track_Sales.r")
source("Update_Process.r")
source("View_Order.r")


mainMenu <- function() {
  cat("\nMain Menu:\n")
  cat("1. Add new Order\n")
  cat("2. Update Order\n")
  cat("3. Delete Order\n")
  cat("4. View/Track Orders\n")
  cat("5. Track Sales\n")
  cat("6. Exit\n")

  choice <- readline(prompt = "Enter your choice (1-6): ")

  if (choice == "1") {
    processOrder()
  } 
  else if (choice == "2") {
     UpdateProcess()
  }
  else if (choice == "3") {
     delete_orders()
  }
  else if (choice == "4") {
     get_order_info
  }
  else if (choice == "5") {
     track_sales()
  }
  else if (choice == "6") {
    cat("Exiting...\n")
    dbDisconnect(con)
    return()
  } else {
    cat("Invalid choice. Please enter a valid choice.\n")
    mainMenu()
  }
}


