#Import libraries
library(RPostgres)

#input order variable
ITEMS  = readline()

#Order data frame
order_d = data.frame(
    id = c(),
    title = c(),
    price = c()
)
order_tbl <- data.frame(
    Qnty = c(),
    order_date <- c(),
    total <- c()
)