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
  read.table(log, header = TRUE, check.names = FALSE, skipNul = TRUE, sep = "\t", fileEncoding = "latin1")
}

# 3. Plots
observeEvent(input$monitor, {

  shiny::validate(need(length(userLogs()) > 0, "no files selected"))

  ## 3.1 read files into dataframe. Use tryCatch to valid the DF.
  logDF <- tryCatch(
    {
      purrr::map_df(userLogs(), read_log) %>%
        discard(~all(is.na(.))) %>%
        mutate(Date = as.POSIXct(Date, format = "%Y-%m-%d %H:%M:%S")) %>%
        mutate(Date = format(Date, format="%Y-%m-%d"))
      },  error = function(e){
        return(NULL)
      }
    )

  validate(need(!is.null(logDF), "no files selected"))

  ## 3.2 get parameters
  observe({
    x <- colnames(logDF)[-c(1:3)]
    updateSelectInput(session,
                      inputId = "selected_parameters",
                      choices = x,
                      selected = x[1])
  })

  nDate <- length(levels(as.factor(logDF$Date))) ## get number of Date levels

  ## 3.3 plot
  output$logFiles <- renderPlotly({

    req(input$selected_parameters) # to eliminate the message 'Error: invalid first argument'
    plot_ly(data = logDF,
            x = ~ Date,
            y = ~ get(input$selected_parameters),
            color = ~ Date,
            colors =  brewer.pal(min(max(3, nDate), 12), "Paired"), ## min =3, max = 12
            type = 'scatter',
            mode = 'markers',
            size = 10,
            hoverinfo = 'x+y') %>%
      layout(xaxis = list(title = "", tickangle = 90),
             yaxis = list(title = "", exponentformat = "E"))

    })

})
