#Import libraries

library(RPostgres)
source('con.R')
#input order variable


#Order data frames
order_tbl1 = data.frame(id = c(), title = c(), price = c())

order_tbl <- data.frame(Qnty = c(), order_date <- c(), total <- c())


#Fetch items from menu table
query = ('SELECT id, title, price FROM table87')
df = dbSendQuery(conn, query)
df = dbFetch(df)
menu_items = as.list(df$id)


#Function to make order from order table
make_order <- function(){
    ITEMS <<- readline()
    if (ITEMS %in% menu_items){
        fetch_orders()
    } else {
        print('item not found')
    }
}

#Function to fetch items from database
fetch_orders <- function() {
    query = paste("SELECT id, title, price FROM table87 WHERE id =", ITEMS)
    df = dbSendQuery(conn, query)
    df = dbFetch(df)
    order_tbl1 = rbind(order_tbl1, df)
    print(order_tbl1)
}

#confirm order
confirm_order <- function(){
    order_c = readline(prompt= '1 add orders   3 Remove items: ')

    if (order_c == '1'){
        make_order()
    } else if (order_c == '3') {
       item_to_rem = as.integer(readline(prompt='Remove:'))
       order_tbl1 = order_tbl1[-c(item_to_rem)]
       print(order_tbl1)
    } else {
    print('Thanks for shopping')
}
}

make_order()
confirm_order()