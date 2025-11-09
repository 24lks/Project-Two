library(shiny)

# Source your ui and server
source("ui.R")
source("server.R")

shinyApp(ui = ui, server = server)
library(rsconnect)

