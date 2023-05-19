library(DBI)
library(RPostgreSQL)
source("con.R")

track_sales <- function(order_id){
  # Establish connection to database
  #conn <- odbcDriverConnect(conn)

  # Construct SQL query to track the sales
  sql <- paste("SELECT Item_category, Item_name, sum(Order_quantity) as Quantity_Sold, sum(Order_total) AS total_sales
                FROM final_orders
                GROUP BY Item_category,Item_name")


  #Execute query and store results in a data frame
  result <- dbGetQuery(con, sql)

  # Close database connection
  #$odbcClose(conn)

  # Return result
  print(result)
}
track_sales()

