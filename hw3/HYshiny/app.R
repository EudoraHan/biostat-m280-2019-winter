library(shiny)
library(tidyverse)
library(ggplot2)
library(shinythemes)

# Imput Data
totpay <- readRDS("TotalPay.rds")
highp <- readRDS("HighPay.rds")
meanp <- readRDS("MeanPay.rds")
medp <- readRDS("MedianPay.rds")
cost <- readRDS("HighCost.rds")
bonus <- readRDS("bonus.rds")

# UI part 
ui <- navbarPage(title = "LA Employee Payroll",
                 theme = shinytheme("flatly"),
                 tabPanel("Total Payroll",
                          titlePanel("Total payroll by LA city"),
                          plotOutput(outputId = "Totalpay")
                 ),
                 
                 tabPanel("Who Earned Most",
                          titlePanel("Who Earned Most?"),
                          sidebarLayout(
                            sidebarPanel(
                              numericInput(inputId = "num1",
                                           label = "Number of highest paid 
                                           employees;",
                                           value = 10),
                              selectInput(inputId = "Year1",
                                          label = "Year:",
                                          choices = c("2017", "2016", "2015", 
                                                      "2014", "2013"), 
                                          selected = "2017")
                            ),
                            
                            mainPanel(tableOutput(outputId = "Highpay"))
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
                                          choices = c("2017", "2016", "2015",
                                                      "2014", "2013"), 
                                          selected = "2017"),
                              radioButtons(inputId = "method",
                                           label = "Methods:",
                                           choices = c("Mean", "Median"),
                                           "Median")
                            ),
                            mainPanel(tableOutput(outputId = "Mpay"))
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
                                          choices = c("2017", "2016", "2015", 
                                                      "2014", "2013"), 
                                          selected = "2017")
                            ),
                            mainPanel(tableOutput(outputId = "Highcost"))
                          )
                 ),
                 
                 tabPanel("Which Departments have Highest Bonus",
                          titlePanel("Which Departments have Highest 
                                     Permanent Bonus Pay?"),
                          sidebarLayout(
                            sidebarPanel(
                              numericInput(inputId = "num4",
                                           label = "Number of department:",
                                           value = 5),
                              selectInput(inputId = "Year4",
                                          label = "Year:",
                                          choices = c("2017", "2016", "2015", 
                                                      "2014", "2013"), 
                                          selected = "2017")
                            ),
                            mainPanel(tableOutput(outputId = "Bonus"))
                          )
                 )
                 
                 
)

# server part
server <- function(input, output) {
  # For question 1
  output$Totalpay <- renderPlot({
    ggplot(data = totpay, aes(x = Year, y = Payment/1000000, fill = Type)) +
      geom_col() +
      labs(x = "Year", y = "Pay(million)") +
      scale_fill_manual(values = c("#D55E00", "#009E73", "#0072B2"),
                        name="Type of Pay",
                        breaks=c("Tbase", "Tover", "Tother"),
                        labels=c("Total Basepay", "Total Overtimepay", 
                                 "Total Otherpay"))
  })
  
  # Who earned most?
  output$Highpay <- renderTable({
    highp$Year <- format(highp$Year, digits = 0)
    highp %>% filter(Year == input$Year1) %>%
      head(input$num1)
  })
  
  # Which departments earn most
  output$Mpay <- renderTable({
    meanp$Year <- format(meanp$Year, digits = 0)
    medp$Year <- format(medp$Year, digits = 0)
    if (input$method == "Mean") {
      meanp %>% filter(Year == input$Year2) %>%
        head(input$num2)
    } else {
      medp  %>% filter(Year == input$Year2) %>%
        head(input$num2)
    }
  })
  
  ## Which departments cost most?
  output$Highcost <- renderTable({
    cost$Year <- format(cost$Year, digits = 0)
    cost %>% filter(Year == input$Year3) %>%
      head(input$num3)
  })
  
  ## Which departments have the hightest permanent bonus pay?
  output$Bonus <- renderTable({
    bonus$Year <- format(bonus$Year, digits = 0)
    bonus %>% filter(Year == input$Year4) %>%
      head(input$num4)
  })
  
}

shinyApp(ui = ui, server = server)