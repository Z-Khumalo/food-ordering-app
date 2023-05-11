
# Load necessary packages
library(DBI)
library(RPostgreSQL)
source("con.R")


# Prompt user for login credentials
username <- readline("Enter your username: ")
password <- readline("Enter your password: ")

# Construct SQL query to check credentials against database
sql <- paste0("SELECT * FROM Administrator WHERE Admin_user_name = '", username, "' AND Admin_password = '", password, "'")

# Execute query and check number of rows returned
res <- dbGetQuery(con, sql)
if (nrow(res) == 1) {
  # Successful login, grant access to resources
  print("Login successful!")
} else {
  # Failed login, deny access
  print("Invalid username or password.")
}




