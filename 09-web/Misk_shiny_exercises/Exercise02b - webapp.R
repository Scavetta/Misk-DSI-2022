# shiny webapp Exercise 2

library(shiny)
library(tidyverse)

# Define UI for application that draws a scatterplot
ui <- fluidPage(

    # Sidebar with a radiobuttons for shapre
    sidebarLayout(
        sidebarPanel(
            # XXXXXXX Insert input panel here
        ),

        # Show a plot of the generated distribution
        mainPanel(
            # XXXXXXX # plot output here
        )
    )
)

# Define server logic required to draw plot
server <- function(input, output) {

    # XXXXX Render plot here
}

# Run the application
shinyApp(ui = ui, server = server)
