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
           p("Log file is text file with a .log file extension (*log), which is used to store lists of information.
             The default directory for the log files of, i.e., Oibitrap Exactive instrument, is", span("C:\\Xcalibur\\system\\Exactive\\log.", style = "color:#f15c42")),
           p(strong("LogViewer"), " section provides a user-friendly way to interactively view the system information."),

           p("1. You can upload a single log file to monitor different instrument parameters of the day or multiple log files to compare the instrument status among different dates
             in", code("File Inut Panel"), ", and then click", code("Monitor"), "button to view the results."),
           p("2. There are more than 30 parameters to inspect, you can use", code("Select Parameters to View"), "panel to select the parameter of interest."),
           p("3.", code("Plot"), "panel allows you to interactively view, compare and save the results.
             Data point from the same day means that they were measured at different time points of the day."),
           p("4. You can click", strong('+'), "and", strong('-'), "in the tab to show or hide the contents in the tab.")
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
           fileInput(inputId = "logs",
                     label = "Upload log files:",
                     multiple = TRUE,
                     placeholder = "C:/Xcalibur/system/Exactive/log",
                     accept = c(".log")
                     ),

           actionButton("monitor", "Monitor", icon("paper-plane"),
                        style = "color: #fff; background-color: #CD0000; border-color: #9E0000"
                        )
           )

         ),


  column(width = 7,

         box(
           width = 12,
           inputId = "input_card",
           title = strong("Select Parameters to View"),
           status = "success",
           solidHeader = FALSE,
           collapsible = FALSE,
           collapsed = FALSE,
           closable = FALSE,
           selectInput("selected_parameters", label = "", list())

         ),

         box(
           width = 12,
           inputId = "report_card",
           title = strong("Plot"),
           status = "success",
           solidHeader = FALSE,
           collapsible = TRUE,
           collapsed = FALSE,
           closable = FALSE,
           plotlyOutput("logFiles")
           )
         )
  )

