
chartr0 <- function(x) chartr('\\','/', x)

msconvertPath <- reactive({
  return(chartr0(input$msconvert))
})

outPath <- reactive({
  return(chartr0(input$outdir))
})

volumes = getVolumes()

observe({
  # 1. choose MSConvert software path
  output$msconvertPath <- renderText(msconvertPath())

  # 2. choose raw files
  shinyFiles::shinyFileChoose(input, "files", roots = volumes())
  if(!is.null(input$files)){
    rawPath <<- parseFilePaths(volumes(), input$files) # dataframe type
    output$filesPath <- renderDataTable(rawPath)
  }

  # 3. choose output folder
  output$outDir <- renderText(outPath())

})

# 4. execute conversion
observeEvent(input$convert, {
  withProgress(message = "Converting...",
               detail = "This may take a while...",
               value = 0.4, {

                 for (i in 1:nrow(rawPath)) {
                   msconvert_command <- convert <- paste0('"', msconvertPath(), '"', " msconvert --zlib --filter ", '"', "peakPicking true [1,2]", '"', " ",'"', rawPath$datapath[i], '"', " -o ", '"', outPath(), '"')
                   system(msconvert_command)
                 }


               })

})
