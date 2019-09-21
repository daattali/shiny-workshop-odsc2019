library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

players <- read.csv("data/nba2018.csv")

ui <- fluidPage(
  titlePanel("NBA 2018/19 Player Stats"),
  sidebarLayout(
    sidebarPanel(
      "Exploring all player stats from the NBA 2018/19 season",
      h3("Filters"),
      sliderInput(
        inputId = "VORP",
        label = "Player VORP rating at least",
        min = -3, max = 10,
        value = 0
      ),
      selectInput(
        "Team", "Team",
        unique(players$Team),
        selected = "Golden State Warriors"
      )
    ),
    mainPanel(
      strong(
        "There are",
        textOutput("num_players", inline = TRUE),
        "players in the dataset"
      ),
      plotOutput("nba_plot"),
      tableOutput("players_data")
    )
  )
)

server <- function(input, output, session) {

  output$players_data <- renderTable({
    data <- players %>%
      filter(VORP >= input$VORP,
             Team %in% input$Team)

    data
  })

  output$num_players <- renderText({

  })

  # Build the plot output here

}

shinyApp(ui, server)
