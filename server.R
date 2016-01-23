# server.R

library(tm)
library(wordcloud)
library(twitteR)
library(NLP)
library(httr)
library(RColorBrewer)
library(base64enc)

#source("helpers.R")

shinyServer(function(input, output) {

#         consumer_key    <- 'I93siyvj9SerduUtQUJP0kaQh'
#         consumer_secret <- 'tCIQGP4w8HBpbr5yC6UCPJ2KIwQg4LEb8ieXv5IU9LJYNIW6SA'
#         access_token    <- '137102428-2MhdjqeLoc5wQiRHy0knBnGe6cTODIINjHhbqLgb'
#         access_secret   <- 'Ze9L8gcjK63HDLwVJ9DeYKcAcfcNEi3G47VUtQP5a2pNd'
#         setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)
#         
#         token <- get("oauth_token", twitteR:::oauth_cache) #Save the credentials info
        new_token <- load("./my_oauth.Rdata")
        use_oauth_token(token)

        token$cache()
        
#         output$searchstr <- renderText({ 
#                 paste("You have selected this", input$searchstr)
#         })
        observe({
               
        sincedt <- as.character(input$date)
        twit <- searchTwitter(input$searchstr, n=input$id1, since = sincedt, retryOnRateLimit = 120, lang = "en")
        
        twtlist <- sapply(twit, function(x) x$getText())
        twtlist <- gsub("[[:punct:]]", "", twtlist)
        #twtlist <- gsub("[[:xdigit:]]", "", twtlist)
        twtlist <- gsub("[[:cntrl:]]", "", twtlist)
        
        twtcorpus <- Corpus(VectorSource(twtlist))
        twtcorpus <- tm_map(twtcorpus, tolower)
        twtcorpus <- tm_map(twtcorpus, removePunctuation)
        twtcorpus <- tm_map(twtcorpus,
                            function(x)removeWords(x,stopwords()))
        twtcorpus <- tm_map(twtcorpus, PlainTextDocument)
        
        output$search <- renderPlot({
                wordcloud(twtcorpus, min.freq=5, scale=c(4,1),
                          random.color=TRUE, max.word=100, random.order=TRUE, 
                          colors=brewer.pal(8, "Dark2"))
        })
        output$data <- renderDataTable({
                as.data.frame(twtlist)
        })
        })
}
)
