library(RPostgres)

conn = dbConnect(
Postgres(), 
user='postgres', 
port = '5432',
password ='', 
dbname= 'food_ordering_db', 
host='localhost')
