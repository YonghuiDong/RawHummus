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
           p("1. You can upload your data in", strong("Upload Data Panel"), "tab. CCWeights accepts csv, xls and xlsx formats."),
           p("2. Your data should contain at least two columns, i.e.,", span("Concentration", style = "color:#f15c42"), "and", span("Response", style = "color:#f15c42"),
             ". If your data contains information from more than one compounds, you need to add an additional column, named", span("Compound", style = "color:#f15c42"),
             ". If you have internal standards in your data, you need to add a column named", span("IS", style = "color:#f15c42"), ". Note that column names
             are case-sensitive."),
           p("3. You can load the two example datasets in", strong("Upload Data Panel"), "tab to check the data format."),
           p("4. You can view the data in", strong("Loaded Data"), "tab,
             and view the summary statistics of the loaded data in", strong("Data Summary"), "."),
           p("5. You can click", strong('+'), "and", strong('-'), "in the tab to show or hide the contents in the tab.")
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
                     placeholder = "example: C:/Program Files (x86)/ProteoWizard/ProteoWizard/msconvert.exe"),

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
                     placeholder = "example: D:/Data"),

           actionButton("convert", "Convert", icon("paper-plane"),
                        style = "color: #fff; background-color: #CD0000; border-color: #9E0000"
                        )
           )
         ),


  column(width = 7,
         # box(
         #    width = 12,
         #    inputId = "msconvert_card",
         #    title = strong("MSConvert"),
         #    status = "success",
         #    solidHeader = FALSE,
         #    collapsible = TRUE,
         #    collapsed = FALSE,
         #    closable = FALSE,
         #    textOutput("msconvertPath")
         #    ),

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
            dataTableOutput("filesPath")
            ),

          # box(
          #   width = 12,
          #   inputId = "outDir_card",
          #   title = strong("Converted Data"),
          #   status = "success",
          #   solidHeader = FALSE,
          #   collapsible = TRUE,
          #   collapsed = FALSE,
          #   closable = FALSE,
          #   textOutput("outDir")
          # ),

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

