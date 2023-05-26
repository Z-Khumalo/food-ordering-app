library(RPostgreSQL)

con <- dbConnect(
  PostgreSQL(),
  dbname = "food_db",
  host = "localhost",
  port = 5432,
  user = "postgres",
  password = " "
)
