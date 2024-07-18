library(shiny)
library(shinydashboard)
library(dplyr)

df2 <- read.csv("data/insurance_data.csv")
df3 <- read.csv("data/vendor_data.csv")
df4 <- dplyr::left_join(df2, df3, by = 'VENDOR_ID')

tabl2 <- df4 %>% aggregate(CLAIM_AMOUNT ~   MARITAL_STATUS + SOCIAL_CLASS + EMPLOYMENT_STATUS, FUN = mean) 

ui <- dashboardPage(
    dashboardHeader(title = "Basic dashboard"),
    dashboardSidebar("This is empty"),
    dashboardBody(
        
        fluidRow(
            box(dataTableOutput("tabl1") )
            
            )
        ),
    skin = "green" 
    )

server <- function(input, output) {
    
    output$tabl1 <- renderDataTable({
        tabl3 <- reactive(tabl2)
        tabl3()
        
    })
}

shinyApp(ui, server)