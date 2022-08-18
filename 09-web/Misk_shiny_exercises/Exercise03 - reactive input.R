# shiny webapp Exercise 3 - reactive input

library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      ##### UI components here
      fileInput("file", "Upload data:")

    ),
    mainPanel(
      #####
      ##### Output components here
      plotOutput("plot")

    )
  )
)


  server <- function(input, output) {
    #####
    ##### Reactive components here
    ##### Replace the XXXXXX with a reactive({}) function to read in a file using read.delim()
    XXXXXX <- XXXXXX({

      XXXXXX <- input$XXXXXX

      read.delim(XXXXXX$datapath)

      })

    output$plot <- renderPlot({
      #####
      ##### Plotting functions here
      output$plot <- renderPlot({plot(XXXXXX)})
      #####
    })
  }

  shinyApp(ui, server)
