library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyFiles)
library(shinyMatrix)
library(shinyvalidate)
library(shinycustomloader)
library(RaMS)
library(data.table)
library(dplyr)
library(plotly)
library(purrr)
library(rmarkdown)


dashboardPage(

  ## Header ----------------------------------------------------------------------
  header = dashboardHeader(
    title = strong("RawHummus")
  ),

  ## Sidebar ----------------------------------------------------------------------
  sidebar = dashboardSidebar(

    sidebarMenu(
      id = "sidebarmenu",
      menuItem(text = strong("Home"), tabName = "home", icon = icon("home")),
      menuItem(text = strong("MSConvert"), tabName = "convert", icon = icon("sync"), badgeLabel = "Local"),
      menuItem(text = strong("Evaluation"), tabName = "evaluate", icon = icon("cog")),
      menuItem(text = strong("Contact"), tabName = "contact", icon = icon("smile")),
      menuItem(text = strong("Acknowledgement"), tabName = "acknowledgement", icon = icon("heart")),
      hr(),
      menuItem(text = strong("Evaluation"), tabName = "evaluate", icon = icon("chart-bar"))
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
