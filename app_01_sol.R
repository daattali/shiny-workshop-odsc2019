library(shiny)

players <- read.csv("data/nba2018.csv")

ui <- fluidPage(
  nrow(players)
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
