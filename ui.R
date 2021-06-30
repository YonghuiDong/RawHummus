library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyFiles)
library(shinyMatrix)
library(shinyvalidate)
library(RaMS)
library(plotly)
library(DT)
library(shinycustomloader)

dashboardPage(

  ## Header ----------------------------------------------------------------------
  header = dashboardHeader(),

  ## Sidebar ----------------------------------------------------------------------
  sidebar = dashboardSidebar(

    sidebarMenu(
      menuItem(text = "Home", tabName = "home", icon = icon("home")),
      menuItem(text = "File Conversion", tabName = "convert", icon = icon("sync"), badgeLabel = "Local"),
      menuItem(text = "Evaluation", tabName = "evaluate", icon = icon("chart-bar"), badgeLabel = "Online"),
      hr(),
      menuItem(text = "Evaluation", tabName = "evaluate", icon = icon("chart-bar"))
      )
    ),

  ## Body ----------------------------------------------------------------------
  body = dashboardBody(
    tabItems(
      tabItem(tabName = "home",  source("ui-tab-home.R", local = TRUE)$value),
      tabItem(tabName = "convert",  source("ui-tab-convert.R", local = TRUE)$value),
      tabItem(tabName = "evaluate",  source("ui-tab-evaluate.R", local = TRUE)$value)
      )
    ),

  ## Footer ----------------------------------------------------------------------
  footer = dashboardFooter()
)
