fluidRow(

  column(width = 12,

         bs4Card(
           width = 12,
           title = "User Guide",
           status = "secondary",
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


  column(width = 3,

         bs4Card(
           width = 12,
           inputId = "input_card",
           title = "Upload data panel",
           status = "primary",
           solidHeader = FALSE,
           collapsible = FALSE,
           collapsed = FALSE,
           closable = FALSE,
           shinyFilesButton('convert2', label='File select', title='Please select a file', multiple = FALSE)
           ),


  column(width = 9,
         bs4Card(
           width = 12,
           inputId = "rawData_card",
           title = "Raw Files",
           status = "secondary",
           solidHeader = FALSE,
           collapsible = TRUE,
           collapsed = FALSE,
           closable = FALSE,
           textOutput("msconvertPath")
           )
         )
  )
  )

