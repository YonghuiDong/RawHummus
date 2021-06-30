# 1. check input files and parameters(if any)

##1.1 check input files
userInput <- reactive({

  infile <- input$convertedData
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

## 1.2 check ppm range
ppms <- InputValidator$new()
ppms$add_rule("myppm", sv_between(1, 100))
ppms$enable()

## 1.3 check rt tolerance range
rts <- InputValidator$new()
rts$add_rule("myrt", sv_between(0.01, 3))
rts$enable()

# 2. report

output$report_button <- ({NULL})

observeEvent(input$evaluate, {

   ## 2.1 generate report button
  output$report_button <- renderUI({
    validate(need(length(userInput()) >= 2, "Attention: at least 2 data files are required to generate the report"))
    msdata <<- RaMS::grabMSdata(files = userInput())
    downloadButton("report", "Download Report", style="color: #fff; background-color: #00b300; border-color: #009900")
    })

  ## 2.2 generate report
  output$report <- downloadHandler(

    filename <- paste0(Sys.Date(), "_Report.html"),
    content <- function(file){

      tempReport <- file.path(tempdir(), "Report.Rmd")
      file.copy("Report.Rmd", tempReport, overwrite = TRUE)
      params <- list(msdata = msdata,
                     peaks = input$peaks,
                     myppm = input$myppm,
                     myrt = input$myrt)
      rmarkdown::render(tempReport,
                        output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
                        )

      }

    )

})
