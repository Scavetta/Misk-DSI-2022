# shiny webapp Exercise 4 - renderUI

library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      ##### UI components here
      fileInput("file", "Upload data:"),
      uiOutput("nRowUI"),
      actionButton("button", "Go")


    ),
    mainPanel(
      #####
      ##### Output components here
      plotOutput("plot"),
      tableOutput("table")

    )
  )
)


  server <- function(input, output) {
    #####
    ##### Reactive components here
    myData <- reactive({

      inFile <- input$file

      if (is.null(inFile))
        return(NULL)

      read.delim(inFile$datapath)
      })

    # Create Plot
    output$plot <- renderPlot({
      #####
      ##### Plotting functions here
      output$plot <- renderPlot({plot(myData())})
      #####
    })

    # Create Table
    output$table <- renderTable({

      input$button

      head(myData(), isolate({input$nrow}))
    })

    # Create UI
    output$nRowUI <- renderUI({
      req(myData()) # Watchs to see if myData() exists

      # replace XXXXXX with an input widget containing reactive components
      # put the action buttion in this function also.
      XXXXXX
      XXXXXX
    })

  }

  shinyApp(ui, server)
