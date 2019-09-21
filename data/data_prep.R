# Source: https://www.kaggle.com/schmadam97/nba-regular-season-stats-20182019
players <- readr::read_csv("data/nba2018_raw.csv", col_types = readr::cols(), na = "NA")

# Sanity check: all players without a team have no salary
if (!all((players$Team == "") == (players$Salary == "-"))) {
  stop("There is a teamless player with a salary, or a salaryless player with a team")
}

# Players without a team are Free Agents (clearer than just having an empty string)
players$Team[players$Team == ""] <- "<Free Agent>"

# Convert salary to numeric and change "-" salary to 0
players$Salary[players$Salary == "-"] <- 0
players$Salary <- as.numeric(players$Salary)

# Save the clean data
write.csv(players, "data/nba2018.csv", row.names = FALSE)
