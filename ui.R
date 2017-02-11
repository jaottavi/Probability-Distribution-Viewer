#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
# This portion of the app shows the density graph for the different types of plots
#

library(shiny)

# Definition for UI app that draws distribution types
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Probability Distribution Viewer"),
  
  # Sidebar with options for choosing distributions and it's conditions
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        "dist",
        "Distribution Type",
        c("Normal", "Exponential", "Uniform", "Chi-Square")
      ),
      
      sliderInput(
        "n",
        "Number of Observations:",
        min = 10,
        max = 1000,
        value = 500,
        step = 10),
      
      selectInput(
        "color",
        "Color of Graph",
        c("red","blue","green","orange","yellow","steel blue","gold","pink","purple")
      ),
      
      # conditional panels after choice of distribution has been made
      conditionalPanel(
        condition = "input.dist == 'Normal'",
        sliderInput(
          "mean",
          "Mean",
          min = -50,
          max = 50,
          value = 0),
        sliderInput(
          "sd",
          "Standard Deviation",
          min = 0,
          max= 50,
          value = 1)
      ), 
      
      conditionalPanel(
        condition = "input.dist == 'Exponential'",
        sliderInput(
          "rate",
          "Time Between Events",
          min = .1,
          max = 10, 
          value = 1,
          step = .1)
      ),
      
      conditionalPanel(
        condition = "input.dist == 'Uniform'",
        sliderInput(
          "unifMin",
          "Minimum",
          min = -50,
          max = 50,
          value = 0,
          step = 1),
        sliderInput(
          "unifMax",
          "Maximum",
          min = -50,
          max = 50,
          value = 10,
          step = 1)
      ),
      
      conditionalPanel(
        condition = "input.dist == 'Chi-Square'",
        sliderInput(
          "dfChisq",
          "Degrees of Freedom",
          min = 1,
          max = 50,
          value = 1,
          step = 1
        )
      ),
      # submit button to prevent overloading of shiny app
      submitButton("Apply Changes")
       
    ),
    
    
    # Show a plot of the generated density graph
    mainPanel(
      tabsetPanel(
        tabPanel("Plot of Distribution", plotOutput("densPlot")),
        tabPanel("Documentation", htmlOutput("summary"))
      )
       
       )
  )
))
