library(shiny)
library(shinythemes)
library(tidyverse)
library(ggplot2)

# Imput Data
totpay <- readRDS("TotalPay.rds")
highp <- readRDS("HighPay.rds")
meanp <- readRDS("MeanPay.rds")
medp <- readRDS("MedianPay.rds")
cost <- readRDS("HighCost.rds")

# UI part 
ui <- navbarPage(title = "LA Employee Payroll",
  theme = shinytheme("Flatly"),
  tabPanel("Total Payroll",
           titlePanel("Total payroll by LA city"),
           plotOutput(outputId = "Totalpay")),
  
  tabPanel("Who Earned Most",
           titlePanel("Who Earned Most?"),
           sidebarLayout(
             sidebarPanel(
               numericInput(inputId = "num1",
                            label = "Number of highest paid employees",
                            value = 10),
               selectInput(inputId = "Year1",
                           label = "Year:",
                           choices = c("2017", "2016", "2015", "2014", "2013"), selected = "2017")
             ),
             mainPanel(tableOutput(outoutId = "Highpay"))
           )
  ),
  tabPanel("Which Departments Earned Most",
           titlePanel("Which Departments Earned Most?"),
           sidebarLayout(
             sidebarPanel(
               numericInput(inputId = "num2",
                            label = "Number of department:",
                            value = 5),
               selectInput(inputId = "Year2",
                           label = "Year:",
                           choices = c("2017", "2016", "2015", "2014", "2013"), selected = "2017"),
               radioButtons(inputId = "method",
                           label = "Methods:",
                           choices = c("Mean", "Median"), "Median")
             ),
             mainPanel(tableOutput(outoutId = "Mpay"))
           )
  ),
  tabPanel("Which Departments Cost Most",
           titlePanel("Which Departments Cost Most?"),
           sidebarLayout(
             sidebarPanel(
               numericInput(inputId = "num3",
                            label = "Number of department:",
                            value = 5),
               selectInput(inputId = "Year3",
                           label = "Year:",
                           choices = c("2017", "2016", "2015", "2014", "2013"), selected = "2017")
             ),
             mainPanel(tableOutput(outoutId = "Highcost"))
           )
  )
  
                
)

# server part
server <- function(input, output) {
  # For question 1
  output$Totalpay <- renderPlot({
    ggplot(data = totpay, aes(x = Year, y = payment, fill = class)) +
      geom_bar(stat = "identity")
  })
  
  # For question 2
  output$Highpay <- renderTable({
    highp %>% filter(Year == input$Year1) %>%
      head(input$num1)
  })
  
  #Which departments earn most
  output$Mpay <- renderTable({
    if (input$method == "Mean") {
      meanp %>% filter(Year == input$Year2) %>%
        head(input$num2)
    } else {
      medp  %>% filter(Year == input$Year2) %>%
        head(input$num2)
    }
  })
  
  ##Which departments cost most?
  output$Highcost <- renderTable({
    cost %>% filter(Year == input$Year3) %>%
      head(input$num3)
  })
  
}

shinyApp(ui = ui, server = server)