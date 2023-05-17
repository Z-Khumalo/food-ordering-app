#Import libraries

library(RPostgres)
source('con.R')
#input order variable


#Order data frames
order_tbl <- data.frame()


#Fetch items from menu table
query = ('SELECT item_id, item_name, item_price, item_category 
        FROM menu')
df = dbSendQuery(conn, query)
df = dbFetch(df)
menu_items = as.list(df$id)

add_order = function(){
    if (nrow(order_tbl) > 0){
        confirm_order()
    } else {
       make_order()
    }
}

remove_item = function(){
    item_to_remove <- readline(prompt = "Remove: ")
    item_to_remove <- as.integer(item_to_remove)
    order_tbl<- order_tbl[-c(item_to_remove),]
    print(order_tbl)
}

delete_order = function(){
    order_tbl = order_tbl[0,]
    make_order()
}
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
    order_tbl1 <-  data.frame(id = c(), title = c(), price = c(),item_price = c())
    query <- paste("SELEC T item_id,item_name, item_price, item_category 
                    FROM menu 
                    WHERE item_id =", ITEMS)
    df <- dbSendQuery(conn, query)
    df <- dbFetch(df)
    order_tbl1 <-  rbind(order_tbl1, df)
    order_tbl <<- rbind(order_tbl,order_tbl1)
    print(order_tbl)

    confirm_order()
}

#confirm order
confirm_order <- function(){
    order_c = readline(prompt= '1 add orders   3 Remove items: ')

    if (order_c == '1'){
        make_order()
    } else if (order_c == '3') {
        remove_item()
        add_order()
    } else {
        delete_order()
}
}

make_order()