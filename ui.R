library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Parameter Estimation"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("size",
                  "Samples size:",
                  min=50,
                  max=2000,
                  value=1000),
      
      sliderInput("p",
                  "Probability:",
                  min=0.1,
                  max=0.9,
                  value=0.5),
      
      sliderInput("R",
                  "repeat:",
                  min=50,
                  max=500,
                  value=100),
      
      selectInput("type", label = h3("Select type"), 
                  choices = list("Expect" = 1, "Variance" = 2,
                                  selected = 1))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))