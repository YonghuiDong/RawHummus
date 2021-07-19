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

## 1.2 check noise range
noises <- shinyvalidate::InputValidator$new()
noises$add_rule("mynoise", sv_between(0, 10000000))
noises$enable()

## 1.3 check ppm range
ppms <- shinyvalidate::InputValidator$new()
ppms$add_rule("myppm", sv_between(1, 100))
ppms$enable()

## 1.4 check rt tolerance range
rts <- shinyvalidate::InputValidator$new()
rts$add_rule("myrt", sv_between(0.01, 5))
rts$enable()

## 1.5 get noise input
mynoise <- reactive({
  return(input$mynoise)
})

## 1.4 get peaks input
mypeaks <- reactive({
  return(input$mypeaks)
})

## 1.5 get ppm input
myppm <- reactive({
  return(input$myppm)
})

## 1.6 get rt input
myrt <- reactive({
  return(input$myrt)
})

# 2. report

output$report_button <- ({NULL})

observeEvent(input$evaluate, {

   ## 2.1 generate report button
  output$report_button <- renderUI({
    shiny::validate(need(length(userInput()) >= 2, "Attention: at least 2 data files are required"))
    msdata <<- RaMS::grabMSdata(files = userInput(), grab_what = c("MS1", "MS2", "TIC"))
    downloadButton("report", "Download Report", style="color: #fff; background-color: #00b300; border-color: #009900")
    })

})

## 2.2 generate report

output$report <- downloadHandler(

  filename <- paste0(Sys.Date(), "_Report.html"),
  content <- function(file){

    shiny::withProgress(
      message = "Generating report",
      detail = "This may take a while...",
      value = 0.4,
      {

        tempReport <- file.path(tempdir(), "Report.Rmd")
        tempCSS <- file.path(tempdir(), "style.css")
        tempLogo <- file.path(tempdir(), "logo.png")
        file.copy("Report.Rmd", tempReport, overwrite = TRUE)
        file.copy("style.css", tempCSS)
        file.copy("logo.png", tempLogo)
        params <- list(msdata = msdata,
                       mynoise = mynoise(),
                       mypeaks = mypeaks(),
                       myppm = myppm(),
                       myrt = myrt())
        rmarkdown::render(tempReport,
                          output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv()))

        })

    }

)

