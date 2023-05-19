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
menu_items = as.list(df$item_id)

add_order = function(){
    if (nrow(order_tbl) > 0){
        print(order_tbl)
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
    m = readline(prompt = 'Are you sure you want to cancel order? Y/N')

    if (m == 'y'){
        order_tbl <<- order_tbl[0,]
        make_order()
    } else {
       add_order()
    }
    
}
#Function to make order from order table
make_order <- function(){
    item <<- readline(prompt = 'Enter item #: ')
    if (item %in% menu_items){
        fetch_orders()
    } else {
        print('item not found')
        add_order()
    }
}

#Function to fetch items from database
fetch_orders <- function() {
    order_tbl1 <-  data.frame(id = c(), title = c(), price = c(),item_price = c())
    query <- paste("SELECT item_id,item_name, item_price, item_category 
                    FROM menu 
                    WHERE item_id =", item)
    df <- dbSendQuery(conn, query)
    df <- dbFetch(df)
    order_tbl1 <-  rbind(order_tbl1, df)
    order_tbl <<- rbind(order_tbl,order_tbl1)
    print(order_tbl)

    confirm_order()
}

#confirm order
confirm_order <- function(){
    order_c = readline(prompt= '\n 1 = Add order \n3 = Remove item  \nC = Cancel  \n4 = Proceded to checkout: ')

    if (order_c == '1'){
        make_order()
    } else if (order_c == '3') {
        remove_item()
        add_order()
    } else if (order_c == 'C') {
        delete_order()
}   else if (order_c == '4') {
    
}  else {
    print('invalid option')
    add_order()
 }
}

make_order()