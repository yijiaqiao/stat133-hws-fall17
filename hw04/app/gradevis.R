
library(shiny)
library(ggvis)
library(dplyr)

source('../code/functions.R')

# read `cleandata.csv` to a new data frame
scores <- read.csv(file = "../data/cleandata/cleanscores.csv", header = TRUE)

# set up variables
#grade <- scores$Grade
gradetitle = c("A+", 'A', 'A-', "B+", 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F')
gradestats <- as.data.frame(table(scores$Grade))
gradestats<- gradestats[match(gradetitle, gradestats$Var1), ]
colnames(gradestats) <- c("Grade", "Freq")
gradestats$Prop <- round(gradestats$Freq/344, 2)

texts <- c('HW1', 'HW2', 'HW3', 'HW4', 'HW5', 'HW6', 'HW7', 'HW8', 'HW9', 'ATT', 'Test1', 'Test2', 'Lab', 'Quiz1', 'Quiz2', 'Quiz3', 'Quiz4', 'Homework', 'Quiz', 'Lab', 'Overall')

# Define UI 
ui <- fluidPage(
   
   # Application title
   titlePanel("Grade Visualizer"),
   
   # Siderbar
   sidebarPanel(
     conditionalPanel(condition = "input.change==1", h4("Grades Distribution"), tableOutput(outputId = "barchart")),
     conditionalPanel(condition = "input.change == 2", 
                      selectInput(inputId = "var2", label = "X-axis variable", choices = texts, selected = 'HW1'),
                      sliderInput(inputId = "bins", label = "Bin width", value = 10, min = 1, max = 10)),
     conditionalPanel(condition = "input.change==3", 
                      selectInput(inputId = "xvar3", label = "X-axis variable", choices = texts, selected = "Test1"),
                      selectInput(inputId = "yvar3", label = "Y-axis variable", choices = texts, selected = "Overall"),
                      sliderInput(inputId = "op", label = "Opacity", value = 0.5, min = 0, max = 1),
                      radioButtons(inputId = "method", label = "Show Line", choices = c("none", "lm", "loess"))
                      )),
      
      # Mainpanel with three tabs
      mainPanel(
         tabsetPanel(
           tabPanel("Barchart", value = 1, uiOutput("barchart1_ui"), ggvisOutput("barchart1")),
           tabPanel("Histogram", value = 2, uiOutput("histogram2_ui"), ggvisOutput("histogram2"), h5("Summary Statistics: "),
                    verbatimTextOutput("sumstats")),
           tabPanel("Scatterplot", value = 3, uiOutput("scatterplot3_ui"), ggvisOutput("scatterplot3"), h5("Correlation: "),
                    verbatimTextOutput("cor")),
           id = "change"
         )
      )
   )


# Define server logic for distribution, histogram and scatterplot
server <- function(input, output) {
   # Distribution
   output$barchart <- renderTable({gradestats})
   {gradestats %>%
       ggvis(~Grade, ~Freq)%>%
       add_axis('y', title = 'frequency')%>%
       layer_bars(fill:='cornflowerblue', stroke:='cornflowerblue', width = 0.87, opacity := 0.7)%>%
       bind_shiny('barchart1', 'barchart1_ui')}
   
   # Histogram
   histogram2 <- reactive({
     v_x <- prop('x', as.symbol(input$var2))
     #histogram
      scores%>%
       ggvis(x = v_x)%>% 
       layer_histograms(fill:='darkgrey', stroke:= 'white', width = input$bins)
   })
     
     histogram2 %>% bind_shiny('histogram2')
     
     output$sumstats = renderPrint({
       print_stats(summary_stats(scores[,input$var2]))
     })
     
     
    # Scatterplot
     scatterplot3 <- reactive({
       x_value <- prop('x', as.symbol(input$xvar3))
       y_value <- prop('y', as.symbol(input$yvar3))
       
       if (input$method == 'none') {
         scores%>% 
           ggvis(x = x_value, y = y_value)%>%
           layer_points(opacity := input$op)
       } else {
         scores%>% 
           ggvis(x = x_value, y = y_value)%>%
           layer_points(opacity := input$op)%>%
           layer_model_predictions(model = input$method)
       }
     })
     scatterplot3%>% bind_shiny('scatterplot3')
     output$cor <- renderText({
       cor(scores[, input$xvar3], 
           scores[, input$yvar3])
     })
}

# Run the application 
shinyApp(ui = ui, server = server)

