# 1. check input files
userLogs <- reactive({

  infile <- input$logs
  if (is.null(infile)){
    return(NULL)
  } else {
    ## keep original file names
    oldNames = infile$datapath
    newNames = file.path(dirname(infile$datapath), infile$name)
    file.rename(from = oldNames, to = newNames)
    filepath <- newNames
    return(filepath)
  }

})

# 2. Read files function

read_log <- function(log) {
  read.csv(log, header = TRUE, check.names = FALSE, skipNul = TRUE, sep = "\t", fileEncoding = "latin1")
}


# 3. Plots
observeEvent(input$monitor, {

  ## 3.1 dataframe
  logDF <- purrr::map_df(userLogs(), read_log) %>%
    discard(~all(is.na(.))) %>%
    mutate(Date = as.POSIXct(Date, format = "%Y-%m-%d %H:%M:%S")) %>%
    mutate(Date = format(Date, format="%Y-%m-%d"))

  ## 3.2 get parameters
  observe({
    x <- colnames(logDF)[-c(1:3)]
    updateSelectInput(session,
                      inputId = "selected_parameters",
                      choices = x,
                      selected = x[1])
  })


  nDate <- length(levels(as.factor(logDF$Date))) ## get number of Date levels

  output$logFiles <- renderPlotly({

    plot_ly(data = logDF,
            x = ~ Date,
            y = ~ get(input$selected_parameters),
            color = ~ Date,
            colors = brewer.pal(min(max(3, nDate), 12), "Paired"), ## min =3, max = 12
            type = 'scatter',
            mode = 'markers',
            size = 10) %>%
      layout(xaxis = list(title = "", tickangle = 90),
             yaxis = list(title = "", exponentformat = "E"))

    })

})
