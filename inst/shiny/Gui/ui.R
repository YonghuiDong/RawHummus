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
library(RColorBrewer)
library(purrr)
library(rmarkdown)
library(markdown)
library(kableExtra)

## free memory
gc()
memory.limit(9999999999)

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
      hr(),
      menuItem(text = strong("Logviewer"), tabName = "monitor", icon = icon("book")),
      hr(),
      menuItem(text = strong("MSConvert"), tabName = "convert", icon = icon("sync"), badgeLabel = "Local"),
      menuItem(text = strong("QCviewer"), tabName = "evaluate", icon = icon("bell-o")),
      hr(),
      menuItem(text = strong("Contact"), tabName = "contact", icon = icon("smile"))
      )
    ),

  ## Body ----------------------------------------------------------------------
  body = dashboardBody(
    tabItems(
      tabItem(tabName = "home",  source("ui-tab-home.R", local = TRUE)$value),
      tabItem(tabName = "monitor",  source("ui-tab-monitor.R", local = TRUE)$value),
      tabItem(tabName = "convert",  source("ui-tab-convert.R", local = TRUE)$value),
      tabItem(tabName = "evaluate",  source("ui-tab-evaluate.R", local = TRUE)$value),
      tabItem(tabName = "contact",  source("ui-tab-contact.R", local = TRUE)$value)
      )
    ),

  ## Footer ----------------------------------------------------------------------
  footer = dashboardFooter(
    left = "Blavatnik Center for Drug Discovery (BCDD), Tel Aviv University",
    right = "Copyright (C) 2021, code licensed under GPL-3.0"
  )
)
