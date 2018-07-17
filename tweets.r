library(RCurl)
library(ROAuth)
library(twitteR)
library(tm)
library(dplyr)
library(stringr)
library(shiny)
library(shinydashboard)

MyData <- read.csv(file="C:/Users/komal/Documents/Tweets/MyData.csv", header=TRUE, sep=",")


bob <- lapply(MyData, as.character)


#lapply(char, function(char)char[grepl("@[[:alnum:]]", char)])









# remove retweet entities
some_txt = gsub('(RT|via)((?:\\b\\W*@\\w+)+)', '',bob )
# remove at people
some_txt = gsub('@\\w+', '', some_txt)
# remove punctuation
some_txt = gsub('[[:punct:]]', '', some_txt)
# remove numbers
some_txt = gsub('[[:digit:]]', '', some_txt)
# remove html links
some_txt = gsub('http\\w+', '', some_txt)
# remove unnecessary spaces
some_txt = gsub('[ \t]{2,}', '', some_txt)
some_txt = gsub('^\\s+|\\s+$', '', some_txt)
some_txt = tolower(some_txt)
some_txt =  gsub("the\\s", '',some_txt)
some_txt =  gsub("for\\s", '',some_txt)
some_txt =  gsub("a\\s", '',some_txt)
some_txt =  gsub("and\\s", '',some_txt)
some_txt =  gsub("from\\s", '',some_txt)
some_txt =  gsub("will\\s", '',some_txt)
some_txt =  gsub("with\\s", '',some_txt)
some_txt =  gsub("to\\s", '',some_txt)
some_txt =  gsub("\\sis\\s", '',some_txt)
some_txt =  gsub("are\\s", '',some_txt)
some_txt=gsub("vote\\s","vote",some_txt)
some_txt =  gsub("brexit", '',some_txt)
some_txt =  gsub("was", '',some_txt)
some_txt =  gsub("amp", '',some_txt)
some_txt =  gsub("this", '',some_txt)
some_txt =  gsub("has", '',some_txt)
some_txt =  gsub("have", '',some_txt)
some_txt =  gsub("been", '',some_txt)
some_txt =  gsub("before", '',some_txt)
some_txt =  gsub("lets", '',some_txt)
some_txt =  gsub("you", '',some_txt)
some_txt =  gsub("today", '',some_txt)
some_txt =  gsub("that", '',some_txt)
some_txt =  gsub("britain", '',some_txt)
some_txt =  gsub("trump", '',some_txt)
some_txt =  gsub("they", '',some_txt)
some_txt =  gsub("should", '',some_txt)
some_txt =  gsub("how", '',some_txt)
some_txt =  gsub("referendum", '',some_txt)
some_txt =  gsub("//sshe", '',some_txt)
some_txt =  gsub("//snow", '',some_txt)
some_txt =  gsub("merkel", '',some_txt)
some_txt =  gsub("these", '',some_txt)
some_txt =  gsub("its", '',some_txt)
some_txt =  gsub("eueu", '',some_txt)
some_txt =  gsub("page", '',some_txt)
some_txt =  gsub("many", '',some_txt)
some_txt =  gsub("trade", '',some_txt)
some_txt =  gsub("europe", '',some_txt)
some_txt =  gsub("why", '',some_txt)
some_txt =  gsub("levels", '',some_txt)
some_txt =  gsub("about", '',some_txt)
some_txt =  gsub("not", '',some_txt)
some_txt =  gsub("around", '',some_txt)
some_txt=gsub("what",'',some_txt)
some_txt=gsub("bbc",'',some_txt)
some_txt=gsub("more",'',some_txt)
some_txt=gsub("our",'',some_txt)
some_txt=gsub("can",'',some_txt)
some_txt=gsub("post",'',some_txt)
some_txt=gsub("would",'',some_txt)
some_txt=gsub("now",'',some_txt)
some_txt=gsub("all",'',some_txt)
some_txt=gsub("^\\safter",'',some_txt)
some_txt=gsub("new",'',some_txt)
some_txt=gsub("business",'',some_txt)
some_txt=gsub("british",'',some_txt)
some_txt=gsub("economy",'',some_txt)
some_txt=gsub("like",'',some_txt)
some_txt=gsub("take",'',some_txt)
some_txt=gsub("much",'',some_txt)
some_txt=gsub("market",'',some_txt)
some_txt=gsub("london",'',some_txt)
some_txt=gsub("impact",'',some_txt)
some_txt=gsub("property",'',some_txt)
some_txt=gsub("than",'',some_txt)
some_txt=gsub("single",'',some_txt)
some_txt=gsub("nigel",'',some_txt)
some_txt=gsub("gove",'',some_txt)
some_txt=gsub("just",'',some_txt)
some_txt=gsub("very",'',some_txt)
some_txt=gsub("says",'',some_txt)
some_txt=gsub("after",'',some_txt)
some_txt=gsub("latest",'',some_txt)
some_txt=gsub("were",'',some_txt)
some_txt=gsub("was",'',some_txt)
some_txt=gsub("but",'',some_txt)
some_txt=gsub("means",'',some_txt)
some_txt=gsub("aher",'',some_txt)
some_txt=gsub("could",'',some_txt)
some_txt=gsub("when",'',some_txt)
some_txt=gsub("\\shis\\s",'',some_txt)

some_txt_corpus <- Corpus(VectorSource(some_txt))

#d
#(freq.terms <- findFreqTerms(d, highfreq = 500 ))
cname <- file.path("C:", "haha")   
cname   
dir(cname)  
library(tm)   
docs <- Corpus(DirSource(cname))   
docs <- tm_map(docs, removeNumbers)  
docs <- tm_map(docs, PlainTextDocument) 
dtm3 <- DocumentTermMatrix(docs)   
dtm3   
library(dplyr)
library(tidytext)

ap_td3 <- tidy(dtm3)
bing <- sentiments %>%
  filter(lexicon == "bing") %>%
  select(word, sentiment)
ap_sentiments3 <- ap_td3 %>%
  inner_join(bing, by = c(term = "word"))

ap_sentiments3
library(tidyr)
ap <- ap_sentiments3 %>%
  count(document, sentiment, wt = count) %>%
  ungroup() %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative) %>%
  arrange(sentiment)
ap_dtm <- data.matrix(ap,rownames.force = NA)
ap_dtm<-ap_dtm[,-1] # removing document row character

runApp("Tweets")
wordcloud::wordcloud(some_txt_corpus,min.freq = 1 ,max.words = 10,scale = c(4,0.5),random.order = FALSE)

