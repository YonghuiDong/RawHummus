# 1. check input files
userInput <- reactive({

  infile <- input$convertedData
  if (is.null(infile)){
    return(NULL)
  } else {
    filepath <- infile$datapath
    return(filepath)
  }

})

# 2. plot
observeEvent(input$evaluate, {

  withProgress(message = 'Working in progress',
               detail = 'It may take a while...', value = 0.3,{

                 ## 2.1 read the files
                 msdata <- RaMS::grabMSdata(files = userInput(), verbosity = 2)
                 ## 2.2 plot
                 output$ticPlot <- renderPlotly({

                   p <- ggplot(msdata$TIC) + geom_line(aes(x = rt, y=int, color=filename)) +
                     labs(x="Retention time (min)", y="Intensity", color="File name: ") +
                     theme(legend.position="top") +
                     theme_bw()
                   ggplotly(p)

                   })

                 })
  })
