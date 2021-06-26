library(shiny)
library(bs4Dash)
  
  ui <- dashboardPage(
    dashboardHeader(),
    dashboardSidebar(
      sidebarMenu(
        menuItem(text = "Tab 1",tabName = "tab1"),
        menuItem(text = "Tab 2", tabName = "tab2")
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "tab1",
          h1("Welcome!"),
          checkboxInput("show", "Show Tab 2", FALSE)
        ),
        tabItem(
          tabName = "tab2",
          h1("Hey! You found me!")
        )
      )
    )
  )
  server <- function(input, output) {}
  shinyApp(ui = ui, server = server)
