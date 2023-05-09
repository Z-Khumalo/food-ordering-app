library(RPostgres)


conn <- dbConnect(
Postgres(), 
port = '5432',
user = 'postgres', 
password ='', 
dbname <- 'postgres', 
host <- 'localhost')