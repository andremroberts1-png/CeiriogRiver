library(shiny)
library(leaflet)

if (file.exists(".env")) readRenviron(".env")

source("R/config.R")
source("R/sheets_backend.R")
source("R/data_access.R")

init_gs4_auth()

ui <- fluidPage(
  titlePanel("River Ceiriog Conservation Map"),
  leafletOutput("map", height = 600)
)

server <- function(input, output, session) {
  points <- get_points()

  output$map <- renderLeaflet({
    leaflet(points) |>
      addTiles() |>
      addMarkers(lng = ~lon, lat = ~lat, label = ~name)
  })
}

shinyApp(ui, server)
