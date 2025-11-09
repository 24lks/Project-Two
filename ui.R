

library(shiny)
library(shinyalert)
library(tidyverse)
library(readxl)
library(ggpubr)
library(tidyr)
library(tidyverse)
library(tidyplots)
library(readxl)
library(DT)
library(bslib)
library(shinycssloaders)


# Load sample data outside the UI
my_sample <- read_excel("project2 (1).xls")

# Define UI
fluidPage(
  theme = bs_theme(preset = "minty"),
  "Welcome to my app!",
  sidebarLayout(
    sidebarPanel(
      h2("Select Region:"),
      #select subset of region
      checkboxGroupInput(
        inputId = "cat_region",
        label = "Region",
        choices = list(
          "Central",
          "East",
          "South",
          "West"
        ),
        selected = "Central"
      ),
      #select subset of segment
      h2("Select Segment:"),
      checkboxGroupInput(
        inputId = "cat_segment",
        label = "Segment",
        choices = list(
          "Consumer",
          "Corporate",
          "Home Office"
          
        ),
        selected = "Consumer"
      ),
      #select first numeric
      h2("Select First Numeric Variable:"),
      selectInput(
        inputId = "num_first",
        label = "Numeric Variable",
        choices = list(
          "Sales",
          "Quantity",
          "Discount",
          "Profit"
        ),
        selected = "Sales"
      ),
      
      # Dynamic slider #1 
      uiOutput("num_first_slider"),
      
      #select second numeric
      h2("Select Second Numeric Variable:"),
      selectInput(
        inputId = "num_second",
        label = "Numeric Variable",
        choices = list(
          "Sales",
          "Quantity",
          "Discount",
          "Profit"
        ),
        selected = "Quantity"
      ),
      # Dynamic slider #2 
      uiOutput("num_second_slider"),
      
      
      
      actionButton("subset_btn", "Subset Data")
    ),
    #Here we set up the main pain
    mainPanel(
      tabsetPanel(
        
        #this tab will tell about the app and aloow users to see the website 
        tabPanel(
          title = "About My App!",
          h3("Welcome to the Superstore Sales App!"),
          p("This dataset gives insights on online orders of a US superstore from 2014-2018."),
          p("In the sidebar you have widgets that allow you to subset the data. In the app main panel Data Download tab you can download the data or data subset. In the Data Exploration tab you can obtain numeric and graphical summaries of the data."),
          tags$a(href = "https://www.kaggle.com/datasets/juhi1994/superstore/discussion?sort=hotness", "Link to data source")
        ),
        
        #this tab will allow users to download the possibly subsetted data
        tabPanel(
          title = "Data Download",
          h3("Dataset on Online Orders of a US Superstore from 2014-2018."),
          DT::dataTableOutput("data_table"),
          downloadButton("downloadData", "Download Current Data")
          
          
        ),
        
        #this tab will allow users to display abnd explore data in a variety of formats
        tabPanel(
          title = "Data Exploration",
          h3("Here you can explore the data with numeric and graphical summaries!"),
          
          #these buttons ask the user what types of data they want to look at, categorical or numeric
          radioButtons(
            inputId = "summary_type",
            label = "Choose summary type:",
            choices = c("Categorical" = "cat", "Numeric" = "num"),
            selected = "cat"
          ),
          
          # Let user choose if they want to see tables or plots
          radioButtons(
            inputId = "explore_options",
            label = "Select what to display:",
            choices = c("Table" = "table", "Plot" = "plot"),
            selected = NULL
          ),
          # Dynamic UI for table/plot controls
          uiOutput("explore_controls"),
          
          #placeholder for outputs
          uiOutput("cat_group_ui"),
          uiOutput("num_group_ui"),
          
          
          # Specific Output placeholders
          # Categorical tables
          tableOutput("oneway_table"),
          tableOutput("two_way_table"),
          
          # Categorical plots
          uiOutput("cat_plots") |> withSpinner(),
          
          
          # Numerical plots
          uiOutput("num_plots") |> withSpinner(), 
          
          # Numerical plots
          uiOutput("num_tables") 
          
        )
      )
    )
  )
)

