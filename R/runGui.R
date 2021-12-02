#' @title Run RawHummus Gui
#' @description Run RawHummus Gui
#' @author Yonghui Dong
#' @import shiny shinydashboardPlus shinyFiles shinyMatrix shinyvalidate shinycustomloader RaMS purrr dplyr plotly RColorBrewer rmarkdown markdown
#' @importFrom shinydashboard sidebarMenu
#' @importFrom kableExtra row_spec
#' @importFrom data.table address
#' @export
#' @return Gui
#' @examples
#' if(interactive()){}

runGui <- function() {
  appDir <- system.file("shiny", "Gui", package = "RawHummus")
  if (appDir == "") {
    stop("Could not find Shiny Gui directory. Try re-installing `RawHummus`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
