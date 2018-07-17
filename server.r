library(tm)
library(wordcloud)
function(input, output) {
  
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  output$plot1 <- renderPlot({
    
    wordcloud_rep( some_txt_corpus, scale=c(4,0.5),
                   min.freq = input$freq, max.words=input$max,random.order=FALSE,
                   colors=brewer.pal(8, "Dark2"))
    
    
  })
  output$plot2 <- renderPlot({
    
    dtm <- DocumentTermMatrix(some_txt_corpus)
    m <- as.matrix(dtm)
    v <- sort(colSums(m),decreasing=TRUE)
    x <- head(v, 4)
    barplot(x,col = "pink",main ="Most frequent words ",
            ylab = "Word frequencies",ylim = c(0, 600)) 
    
  })
  output$plot3 <- renderPlot({
    dtm <- DocumentTermMatrix(some_txt_corpus)
    m <- as.matrix(dtm)
    v <- sort(colSums(m),decreasing=TRUE)
    a <- head(v,10) 
    b <-tidyr::extract_numeric(a)
    K <- as.matrix(b[1:3]) 
    a1 <- colSums(K)
    a2 <- b[4]
    p <- c(a1,a2)
    barplot(p, main = "voteleave v|s remain",  ylab = "FREQUENCY", xlab = "",
            ylim = c(0, 2000), names.arg = c("voteleave", "remain"))
  })
  output$plot4 <- renderPlot({
    barplot(ap_dtm[1,],col = "pink",main ="Sentiment for #brexit:Remain",
            ylab = "sentiment",names.arg = c("negative", "positive","overall sentiment"),ylim = c(-100, 500))
  })
  output$plot5 <- renderPlot({
    barplot(ap_dtm[2,],col = "pink",main ="Sentiment for #brexit:Voteleave ",
            ylab = "sentiment",names.arg = c("negative", "positive","overall sentiment"),ylim = c(-100, 500))
  })
}