#Import libraries
library(RPostgres)

#input order variable
ITEMS  = readline()

#Order data frames
order_tbl1 = data.frame(id = c(), title = c(), price = c())

order_tbl <- data.frame(Qnty = c(), order_date <- c(), total <- c())

#Connec database
conn = dbConnect(Postgres(), 
                user='postgres',
                port = '5432',
                password ='', 
                dbname= 'food_orderingdb', 
                host='localhost')

#Fetch items from menu table
query = ('SELECT id, title, price FROM table87')
df = dbSendQuery(conn, query)
df = dbFetch(df)
menu_items = as.list(df$id)

#Function to make order from order table
make_order <- function(){
    ITEMS = readline()
    if (ITEMS %in% menu_items){
        fetch_orders()
    } else {
        print('item not found')
    }
}

#Function to fetch items from database
fetch_orders <- function() {
    query = paste("SELECT id, title, price FROM table87 WHERE id =" , ITEMS)
    df = dbSendQuery(conn, query)
    df = dbFetch(df)
    order_d = rbind(order_d, df)
    print(order_d)
}