# shiny webapp Exercise 1

library(shiny)
library(tidyverse)

# Define UI for application that draws a scatterplot
ui <- fluidPage(

    # Sidebar with a radiobuttons for shapre
    sidebarLayout(
        sidebarPanel(
            radioButtons("shape", label = "Circle:",
                         c("Filled" = 16,
                           "Hollow" = 1)),

        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("myPlot")
        )
    )
)

# Define server logic required to draw plot
server <- function(input, output) {

    output$myPlot <- renderPlot({
        ggplot(mtcars, aes(mpg, wt)) +
            geom_point(shape = as.numeric(input$shape),
                       # color = input$col,
                       alpha = 0.75, size = 10)
    })
}

# Run the application
shinyApp(ui = ui, server = server)
