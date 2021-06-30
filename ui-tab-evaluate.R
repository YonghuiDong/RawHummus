m <- matrix(data = NA, nrow = 3, ncol = 2, dimnames = list(NULL, c("mz", "Expected RT")))

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
           title = strong("Data Input Panel"),
           status = "primary",
           solidHeader = FALSE,
           collapsible = FALSE,
           collapsed = FALSE,
           closable = FALSE,
           fileInput(inputId = "convertedData",
                     label = "1. Upload data (mzML/mzXML format):",
                     multiple = TRUE,
                     accept = c(".mzML", ".mzXML")),

           shinyMatrix::matrixInput(
             inputId = "mypeaks",
             label = "2. Optional: Add peaks of interest to monitor",
             value = m,
             rows = list(extend = TRUE, names = FALSE),
             cols = list(names = TRUE),
             class = "numeric"
           ),

           numericInput(
             inputId = "myppm",
             label = "mass accuracy tolerance (ppm: 1-100)",
             value = 5,
             min = 1,
             max = 100
           ),

           numericInput(
             inputId = "myrt",
             label = "retention time tolerance (min: 0.01-3)",
             value = 1,
             min = 0.1,
             max = 3
           ),

           actionButton("evaluate", "Evaluate", icon("paper-plane"),
                        style = "color: #fff; background-color: #CD0000; border-color: #9E0000"
                        )
           )

         ),


  column(width = 7,

         box(
           width = 12,
           inputId = "report_card",
           title = strong("Report"),
           status = "success",
           solidHeader = FALSE,
           collapsible = TRUE,
           collapsed = FALSE,
           closable = FALSE,
           shinycustomloader::withLoader(uiOutput("report_button"), type = "html", loader = "dnaspin")
           )
         )
  )

