shinyUI(fluidPage(
        titlePanel("Twitter wordcloud app"),

        sidebarLayout(
                sidebarPanel(
                        helpText("Create wordcloud from tweets selected based on below query."),
                        
                        sliderInput('id1', 'Number of Tweets', 
                                    50, min=50, max=2000, step = 50),
                        dateInput("date", "Tweets from :", value = Sys.Date()-5),
                        textInput("searchstr", "Search string :", "vinodsrin"),
                        submitButton("Search", icon("twitter-square", "fa-3x"))
                        ),
                
                mainPanel(
                        plotOutput("search"),
                        dataTableOutput("data")
                )
        )
))

