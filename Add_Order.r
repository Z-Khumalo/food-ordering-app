Zandile Mdiniso
#4132

phosa malebo — Yesterday at 4:06 PM
library(DBI)
library(RPostgres)
source("con.R")

con <- dbConnect(
Postgres(), 
port = '5432',
user = 'postgres', 
password ='', 
dbname <- 'postgres', 
host <- 'localhost')

displayMenu <- function() {
    query <- "SELECT Item_id, Item_name, Item_price FROM Menu"
    menu_items <- dbGetQuery(con,query)
    cat("Food Menu:\n")
    print(menu_items)
}


processOrder <- function() {
    displayMenu()

    order_data <- data.frame(Order_id = integer(),
                            Order_date = character(),
                            Order_total = character(),
                            Item_id = integer(),
                            # Admin_id = integer(),
                            stringsAsFactors = FALSE)

    repeat{
        item_id <- as.integer(readline(prompt = "Enter Item from Menu list: "))

        if (item_id == 0) {
            break
        }

        query <- paste0("SELECT Item_id FROM Menu WHERE Item_id = ", item_id)
        item_exists <- dbGetQuery(con,query)

        if (nrow(item_exists) ==0) {
            cat("Invalid Item ID. Please enter a valid Item ID from the Menu List.\n")
            next
        }

        quantity <- as.integer(readline(prompt = "Enter the quantity for this item: "))
            if (is.na(quantity) || quantity <= 0) {
                cat("Invalid quantity. Please a positive integer.\n")
                next
            }

        order_date <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")

        query <- paste0("SELECT Item_price FROM Menu WHERE Item_id=", item_id)
        item_price <- dbGetQuery(con,query)$item_price
        total_price <- item_price * quantity

        order_data <- rbind(order_data, data.frame(Order_Id = NA,
                             Order_quantity = as.character(quantity), 
                             Order_date = as.character(order_date),
                             Order_total = as.character(total_price),
                             Item_id = as.integer(item_id)))
                            #  Admin_id = as.integer(admin_id)))      

    }

    cat("Order summary:\n")
    print(order_data)

    dbWriteTable(con, "Orders", order_data, append = TRUE, row.names = FALSE)

}


    # getAdminId <- function(admin_user) {
    #     query <- paste0("SELECT Admin_id FROM Administrator WHERE Admin_user_name = '", admin_user, "'")
    #     admin_id <- dbGetQuery(con, query)$admin_id
    #     return(admin_id)
        
    

print(processOrder())
