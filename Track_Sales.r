library(RPostgres)
source("con.R")
library(DBI)

track_sales <- function(order_id){
  # Establish connection to database
  #conn <- odbcDriverConnect(conn)

  # Construct SQL query to track the sales
  sql <- paste("SELECT b.Item_category, b.Item_name, sum(cast(a.Order_quantity as integer)) as Quantity_Sold, sum(cast(a.Order_total as decimal)) AS total_sales
                FROM Orders a LEFT JOIN Menu b ON a.Item_id = b.Item_id


                GROUP BY b.Item_category,b.Item_name")


  #Execute query and store results in a data frame
  result <- dbGetQuery(conn, sql)

  # Close database connection
  #$odbcClose(conn)

  # Return result
  return(result)
}
 print(track_sales())
