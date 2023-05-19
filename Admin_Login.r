
# Load necessary packages
library(DBI)
library(RPostgreSQL)
source("con.R")



# Function to prompt user for login credentials
get_credentials <- function() {
  username <- readline("Enter your username: ")
  password <- readline("Enter your password: ")
  return(list(username=username, password=password))
}


# Loop until user provides valid credentials or chooses to exit
while (TRUE) {
  # Prompt user for login credentials
  creds <- get_credentials()
  
  
  # Construct SQL query to check credentials against database
  sql <- paste0("SELECT * FROM Administrator WHERE Admin_name = '",
                creds$username, "' AND Admin_password = '", creds$password, "'")
                
                
  
  # Execute query and check number of rows returned
  res <- dbGetQuery(con, sql)
  if (nrow(res) == 1) {
    # Successful login, grant access to resources
    print("Login successful!")
    break
  } else {
    # Failed login, ask user if they want to try again or exit
    choice <- readline("Invalid username or password. Enter 'r' to try again or 'q' to quit: ")
    if (choice == "q") {
      break
    }
  }
}
