
chartr0 <- function(x) chartr('\\','/', x)

msconvertPath <- reactive({
  return(chartr0(input$msconvert))
})

outPath <- reactive({
  return(chartr0(input$outdir))
})

volumes = getVolumes()
rawPath <- NULL

observe({
  # 1. choose MSConvert software path
  # output$msconvertPath <- renderText(msconvertPath())

  # 2. choose raw files
  shinyFiles::shinyFileChoose(input, "files", roots = volumes())

    rawPath <<- parseFilePaths(volumes(), input$files) # dataframe type

    output$filesPath <- renderDataTable({
      rawPath[, c(1, 2, 4)] # show only name, size and filepath
      })

  # # 3. choose output folder
  # output$outDir <- renderText(outPath())

})

# 4. execute conversion
output$convertMessage <- NULL

observeEvent(input$convert, {
  output$convertMessage <- renderText({

    validate(
      need(is.null(msconvertPath()), 'Please add msconvert.exe software path'),
      need(nrow(rawPath) > 0, "Please select (correct) data for conversion"),
      need(is.null(outPath()), 'Please choose a directory to save converted data.')
    )

    for (i in 1:nrow(rawPath)) {
      msconvert_command <- convert <- paste0('"', msconvertPath(), '"', " msconvert --zlib --filter ", '"', "peakPicking true [1,2]", '"', " ",'"', rawPath$datapath[i], '"', " -o ", '"', outPath(), '"')
      system(msconvert_command)
    }

    paste("Conversion Done!", " Converted files are saved in: ", outPath(), sep = "")

  })





})
