
# 1. Load packages --------------------------------------------------------

library(bslib)
library(geodata)
library(gt)
library(leaflet)
library(mapview)
library(sf)
library(shiny)
library(tidyverse)

# 2. Load data ------------------------------------------------------------

## Download data of Cerambyx cerdo
cerambyx <- read_rds("data/cerambyx.rds")

# 3. App ------------------------------------------------------------------

ui <- page_sidebar(
    title   = "Cerambyx dashboard",
    sidebar = sidebar(
        selectInput(
            "year",
            "Year",
            choices  = unique(cerambyx$year),
            selected = 2024
        )
    ),
    layout_columns(
        card(
            leafletOutput("map_cerambyx")
        ),
        card(
            gt_output("table_cerambyx")
        )
    )
)

server <- function(input, output) {

    filtered_cerambyx <- reactive({
        cerambyx %>%
            filter(year == input$year)
    })

    output$map_cerambyx <- renderLeaflet({
        m <- mapview(filtered_cerambyx())
        m@map
    })

    output$table_cerambyx <- render_gt({
        gt(cerambyx)
    })
}

shinyApp(ui, server)
