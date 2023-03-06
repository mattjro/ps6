#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(rsconnect)
library(gridextra)
library(plotly)
UAH_lower_troposphere_long <- read_tsv("C:/Users/Matt/Desktop/info 201 folder/ps6-matthew-ro/UAH-lower-troposphere-long.csv")
View(UAH_lower_troposphere_long)
UAH_lower_globetemp <- filter(UAH_lower_troposphere_long, region == "globe", month == 1)

jan_plot <- ggplot(UAH_lower_globetemp, aes(x = UAH_lower_globetemp$year, y = UAH_lower_globetemp$temp)) + 
  ggtitle("January Yearly Temperatures") +
  xlab("Year") +
  ylab("Temperature")
  geom_line()
jan_plot

jan_table <- grid(UAH_lower_globetemp)
# Define UI for application that draws a histogram
ui <- fluidPage()

    # Application title
    titlePanel("Temperatures of the Lower Troposphere"),

    tabsetPanel()
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
