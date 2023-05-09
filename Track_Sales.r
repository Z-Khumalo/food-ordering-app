library(RPostgres)

get_order_info <- function(order_id){
  # Establish connection to database
  conn <- odbcDriverConnect(conn)
  
  # Construct SQL query to retrieve order information
  query <- paste("SELECT o.Order_id, o.Order_date, o.Order_quantity, o.Order_quantity, m.Item_id, m.item_name, * m.Item_price AS total_sales
        FROM `Orders` o
        INNER JOIN Menu m ON o.Item_id = m.Item_id
        WHERE m.Item_id = ", Item_id)

  
  # Execute query and store results in a data frame
  result <- sqlQuery(conn, query)
  
  # Close database connection
  odbcClose(conn)
  
  # Return result
  return(result)
}

kuhuybi
nhbuhgbu