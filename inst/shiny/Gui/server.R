shinyServer(function(input, output, session) {
  options(shiny.maxRequestSize = 10000 * 1024^2) ## file size limit: 100MB
  source("server-convert.R",local = TRUE)
  source("server-evaluate.R",local = TRUE)
  source("server-monitor.R",local = TRUE)

  observeEvent(input$sidebarmenu, {
    req(input$sidebarmenu == "convert")
    showModal(
      modalDialog(
        title = HTML('<p style="color:#FF6347;"><br>Attention:</br></p>'),
        strong("MSConvert function is designed for local use only. Please read user guide for more details."),
        easyClose = TRUE
        )
      )
    })

  })


