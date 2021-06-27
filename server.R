shinyServer(function(input, output) {
  options(shiny.maxRequestSize = 10000 * 1024^2) ## file size limit: 100MB
  source("server-convert.R",local = TRUE)
  source("server-evaluate.R",local = TRUE)
}
)


