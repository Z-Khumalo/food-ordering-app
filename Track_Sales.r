library(RPostgres)
source("con.R")
library(DBI)

get_order_info <- function(order_id){
  # Establish connection to database
  #conn <- odbcDriverConnect(conn)
  
  # Construct SQL query to retrieve order information
  sql <- paste("SELECT Orders.Order_id, Orders.Order_date, Orders.Order_quantity, Menu.Item_id, Menu.item_name, COUNT(Menu.Item_price) AS total_sales
                FROM Orders
                INNER JOIN Menu ON Orders.Item_id = Menu.Item_id
                GROUP BY Orders.Order_id, Orders.Order_date, Orders.Order_quantity, Menu.Item_id, Menu.item_name")


  
  # Execute query and store results in a data frame
  result <- dbGetQuery(conn, sql)
  
  # Close database connection
  #$odbcClose(conn)
  
  # Return result
  return(result)
}
 print(get_order_info())