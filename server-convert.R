volumes = getVolumes()

observe({
  # 1. choose MSConvert software path, exe file type
  shinyFiles::shinyFileChoose(input, "msconvert", roots = volumes(), filetypes = ("exe"))
  if(!is.null(input$msconvert)){
    softwarePath <- parseFilePaths(volumes(), input$msconvert)
    output$msconvertPath <- renderText(softwarePath$datapath)
  }

  # 2. choose raw files
  shinyFiles::shinyFileChoose(input, "rawfiles", roots = volumes())
  if(!is.null(input$rawfiles)){
    rawPath <- parseFilePaths(volumes(), input$rawfiles)
    output$rawfilesPath <- renderUI({HTML(paste(rawPath$datapath, sep = "", collapse = '<br/>'))})
  }

  # 3. choose output folder
  shinyFiles::shinyDirChoose(input, 'outfiles', roots = volumes())
  if(!is.null(input$outfiles)){
    outfilesdir <- parseDirPath(volumes(), input$outfiles)
    output$outDir <- renderText(outfilesdir)
  }

  # 4. execute conversion
  observeEvent(input$convert, {
    for (i in 1:length(rawPath)) {
      msconvert_command <- paste0('msconvert --mzML -gzv "', rawPath[i], '" -o "', outfilesdir, '"')
      system(msconvert_command)
      }
    })
  })
