library(shinydashboard)
fluidPage(
  # Application title
  titlePanel("Word Cloud"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      titlePanel("For Word Cloud"),
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 500, value = 15),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 300,  value = 100)
    ),
    
    # Show Word Cloud
    mainPanel(
      tabsetPanel(
        tabPanel("Word Cloud",plotOutput("plot1")),
        tabPanel("Bar Graph",plotOutput("plot2")),
        tabPanel("Sentiment Graph",plotOutput("plot3")),
        tabPanel("Sentiment for #brexit:Remain",plotOutput("plot4")),
        tabPanel("Sentiment for #brexit:Voteleave",plotOutput("plot5"))
      ))
  )
)


