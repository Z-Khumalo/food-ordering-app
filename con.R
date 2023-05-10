library(RPostgreSQL)

con <- dbConnect(
  PostgreSQL(),
  dbname = "postgres",
  host = "localhost",
  port = 5432,
  user = "postgres",
  password = " "
)


