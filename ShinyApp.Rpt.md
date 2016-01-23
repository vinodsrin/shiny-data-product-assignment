Twitter Wordcloud Shiny app
========================================================

author: Vinod

date: 2016-01-22

About this app
========================================================

This is a very simple application to analyze twitter posts and identify the common discussion theme

App takes below inputs

- Number of tweets to be filtered
- Date from which relevent tweets to be considered
- Search string used to filter relevent tweets

User then needs to click the ***Search*** button

Use case for this wordcloud app
========================================================

- Provides a visual representation of most used words
- This app can be used to text mine the tweets and identify conversations themes
- This app can be further enhanced to collect, analyze and identify conversation sentiments

Sample code to generate wordcloud
========================================================
<div class="slidescontent" style="width: 1560px; height: 1400px; zoom: 0.6;">

```r
library(wordcloud);
library(RColorBrewer);
library(tm);
library(XML)
doc.html = htmlTreeParse("http://www.kunalracing.co.in/profile.html", useInternal = TRUE)
doc.text = unlist(xpathApply(doc.html, '//p', xmlValue))
docs <- Corpus(VectorSource(doc.text))
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/"); 
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|"); 
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers); 
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removePunctuation); 
docs <- tm_map(docs, stripWhitespace)
dtm <- TermDocumentMatrix(docs);
m <- as.matrix(dtm);
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 2,max.words=100, random.order=FALSE, rot.per=0.35,colors=brewer.pal(8, "Dark2"))
```

Output of wordcloud sample
========================================================




```
Warning message:
package 'knitr' was built under R version 3.2.3 


processing file: ShinyApp.Rpt.Rpres
Loading required package: RColorBrewer
Loading required package: NLP
Quitting from lines 60-82 (ShinyApp.Rpt.Rpres) 
Error: failed to load external entity "http://www.kunalracing.co.in/profile.html"
In addition: Warning messages:
1: package 'tm' was built under R version 3.2.3 
2: package 'XML' was built under R version 3.2.3 
Execution halted
```
