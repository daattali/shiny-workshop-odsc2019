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
      DTOutput("players_data")
    )
  )
)

server <- function(input, output, session) {

  filtered_data <- reactive({
    players %>%
      filter(VORP >= input$VORP,
             Team %in% input$Team)
  })

  output$players_data <- renderDT({
    filtered_data()
  })

  output$num_players <- renderText({
    nrow(filtered_data())
  })

  output$nba_plot <- renderPlot({
    ggplot(filtered_data(), aes(Salary)) +
      geom_histogram() +
      theme_classic() +
      scale_x_log10(labels = scales::comma)
  })

}

shinyApp(ui, server)
