#install.packages('RPostgres')

library(RPostgres)

con <- dbConnect(
  PostgreSQL(),
  dbname = "postgres",
  host = "localhost",
  port = 5432,
  user = "postgres",
  password = " "
)

