# shiny webapp Exercise 4 - eventReactive

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

      req(input$file)

      inFile <- input$file

      if (is.null(inFile))
        return(NULL)

      read.delim(inFile$datapath)
      })

    output$plot <- renderPlot({
      #####
      ##### Plotting functions here
      output$plot <- renderPlot({plot(myData())})
      #####
    })

    # Insert an eventReactive to check if the input$button was pressed
    # if it was use a head function to subset the the data set and
    # save it as myDataHead
    XXXXXX

    output$table <- renderTable({
      myDataHead()
    })


    output$nRowUI <- renderUI({
      req(myData())

      sliderInput("nrow", "Show these rows:",
                  min = 0, max = nrow(myData()), value = nrow(myData()), step = 1)
    })

  }

  shinyApp(ui, server)
