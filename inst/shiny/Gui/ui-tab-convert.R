fluidRow(

  column(width = 12,

         box(
           width = 12,
           title = strong("User Guide"),
           status = "warning",
           solidHeader = FALSE,
           collapsible = TRUE,
           collapsed = FALSE,
           closable = FALSE,
           p(strong("MSconvert"), "tab provides another option for you to convert your raw file to mzML format."),
           p("There are few requirements for this option: ", span("(1)", style = "color:#f15c42"), "for safety reason,
             this function only works on your local computer;", span("(2)", style = "color:#f15c42"), "You need to have msconvert.exe software installed in your computer."),
           p("1. To convert your files, you need to locate", span("msconvert.exe", style = "color:#f15c42"), "software, upload",
             span("raw data", style = "color:#f15c42"), "and select a", span("directory",  style = "color:#f15c42"),
             "to save the concerted files in", code("File Upload Panel")),
           p("2. Once done, you can click", code("Convert"), "button to start conversion. Be patient,
             it may take a while for the conversion to finish.")
           )
         ),


  column(width = 5,

         box(
           width = 12,
           inputId = "input_card",
           title = strong("Upload data panel"),
           status = "primary",
           solidHeader = FALSE,
           collapsible = FALSE,
           collapsed = FALSE,
           closable = FALSE,
           textInput(inputId = "msconvert",
                     label = "Paste msconvert.exe path",
                     value = "Example: C:/Program Files (x86)/ProteoWizard/ProteoWizard 3.0.21175.5b6d9afee/msconvert.exe"),

           strong("Select raw data:"),
           br(),
           br(),
           shinyFiles::shinyFilesButton(id = "files",
                                        label = "Raw Data",
                                        title = "",
                                        multiple = TRUE,
                                        buttonType = "default",
                                        class = NULL),

           br(),
           br(),

           textInput(inputId = "outdir",
                     label = "Paste directory path for saving converted data",
                     value = "Example: C:/Users/BCDDNB3/Downloads"),

           actionButton("convert", "Convert", icon("paper-plane"),
                        style = "color: #fff; background-color: #CD0000; border-color: #9E0000"
                        )
           )
         ),


  column(width = 7,
         box(
            width = 12,
            inputId = "msconvert_card",
            title = strong("MSConvert"),
            status = "success",
            solidHeader = FALSE,
            collapsible = TRUE,
            collapsed = FALSE,
            closable = FALSE,
            textOutput("msconvertPath")
            ),

          box(
            #loadingState(),
            width = 12,
            inputId = "rawData_card",
            title = strong("Raw Data"),
            status = "success",
            solidHeader = FALSE,
            collapsible = TRUE,
            collapsed = FALSE,
            closable = FALSE,
            shiny::dataTableOutput("filesPath")
            ),


         box(
           width = 12,
           inputId = "message_card",
           title = strong("Conversion Status"),
           status = "success",
           solidHeader = FALSE,
           collapsible = TRUE,
           collapsed = FALSE,
           closable = FALSE,
           shinycustomloader::withLoader(textOutput("convertMessage"), type = "html", loader = "pacman")
         )

         )
  )

