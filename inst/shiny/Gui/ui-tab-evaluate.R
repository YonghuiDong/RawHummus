m <- matrix(data = NA, nrow = 3, ncol = 2, dimnames = list(NULL, c("mz", "Expected_RT")))

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
           p(strong("QCviewer"), "tab enables evaluating LCMS system using QC samples"),
           p("1. The converted QC files can be uploaded in", code("Data Input Panel"), ". Note at least two QC files are required."),
           p("2.", strong("QCviewer"), "automatically select 6 peaks accross the retention time (RT) range in your sample to evalute the system. The 6
             peaks are peaks with highest ion intensity from 6 evenly sliced RT ranges.
             Optionally, you could add peaks of interest in", code("Add peaks of interest to monitor"), "panel to evaluate your QC samples in a more targeted
             and specific manner. It is advised to add their RTs in the table. If the RTs are unknown, you can leave them empty.
             You can set the mass accuracy (ppm) and RT windown for QCviewer to search for your peaks in",
             code("mass accuracy tolerance"), "and", code("retention time tolerance"), "panels, respectively."),
           p("3. You can click", code("Evaluate"), "button to start evaluation. Be patient, it may take a while for the evaluation process."),
           p("4. Once evaluation is done, a download butotn is prompt for you to download the evaluation report."),
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

           numericInput(
             inputId = "mynoise",
             label = "2. (Optional but recommended:) Estimated noise intensity level",
             value = 1000,
             min = 0,
             max = 10000000
           ),

           shinyMatrix::matrixInput(
             inputId = "mypeaks",
             label = "3. (Optional:) Add peaks of interest to monitor",
             value = m,
             rows = list(extend = TRUE, names = FALSE),
             cols = list(names = TRUE),
             class = "numeric"
           ),

           numericInput(
             inputId = "myppm",
             label = "mass accuracy tolerance (ppm: 1-100)",
             value = 10,
             min = 1,
             max = 100
           ),

           numericInput(
             inputId = "myrt",
             label = "retention time tolerance (min: 0.01-5)",
             value = 2,
             min = 0.1,
             max = 5
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

