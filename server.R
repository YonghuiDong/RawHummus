shinyServer(function(input, output, session) {
  options(shiny.maxRequestSize = 100 * 1024^2) ## file size limit: 100MB
  source("server-convert.R",local = TRUE)
}
)


