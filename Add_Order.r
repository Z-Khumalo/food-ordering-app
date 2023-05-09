# library(DBI)
# library(RPostgresSQL)
# source("con.R")

# #sample dataframe  # nolint
# menu <- data.frame(Item = c("Burger", "Pizza", "Fries", "Soda"), Price = c(10, 15, 5, 2)) # nolint


 query <- "SELECT DISCTINCT * FROM Menu"
result <- dbGetQuery(con, query)

# # Close the database connection
dbDisconnect(con)

# Print the list of items
# print(result$Item_name)



#function to process new orders
process_order <- function() { # nolint

  # Initialize empty order list
  order_list <- list()
   # nolint
    cat("Food Menu:\n")
    print(menu)

  repeat {
    # Print the food menu and prompt the user to select an item

  item <- readline(prompt = "Enter the name of the item you wish to add to your order: ")   # nolint: line_length_linter.


    # Check if the user wants to finish the order
    if (item == "done") {

      # Print the order summary and prompt the user to confirm the order
      cat("Order summary:\n")
      for (i in seq_along(order_list)) {
        cat(paste0(order_list[[i]]$quantity, "x ", order_list[[i]]$Item_name, ": R", order_list[[i]]$Item_price,"\n"))   # nolint
      }
      confirm <- readline(prompt = "Confirm your order? (y/n): ")
      if (confirm == "y") {
        # Save the order into the ORDER table (you'll need to define the table first)   # nolint
        # ...
        cat("Thank you for your order!\n")
        break
      }
    }
        quantity <- as.numeric(readline(prompt = "Enter the quantity for this item: "))  # nolint
    if (is.na(quantity) || quantity <= 0) {
      cat("Invalid quantity. Please enter a positive integer.\n")
      next
    }
    # nolint
    # Find the selected item in the menu and calculate the total price
    item_info <- Menu[Menu$Item_name == item, ]
    if (nrow(item_info) == 0) {
      cat("Invalid item. Please select an item from the menu.\n")
      next
    }
    price <- item_info$Item_price * quantity
     # nolint
     # nolint
    # Add the selected item to the order list
    order_list[[length(order_list) + 1]] <- list(item = item, quantity = quantity, price = price) # nolint
      # nolint: trailing_whitespace_linter.
    # Prompt the user to add another item to the order
    add_another <- readline(prompt = "Do you want to add another item to your order? (y/n): ")  # nolint
    if (add_another == "n") {

      # Print the order summary and prompt the user to confirm the order
      cat("Order summary:\n")
      for (i in seq_along(order_list)) {
        cat(paste0(order_list[[i]]$quantity, "x ", order_list[[i]]$Item_name, ": R", order_list[[i]]$Item_price, "\n"))  # nolint
      }
      confirm <- readline(prompt = "Proceed to checkout? (y/n): ")
      if (confirm == "y") {
        # Save the order into the ORDER table (still need to define the table first) # nolint
        # ...
        cat("Thank you for your order!\n")
        break
      } else {
        # Start a new order
        order_list <- list()
        next
      }
    }
  }
}

process_order()
