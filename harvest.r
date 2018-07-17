library(RCurl)
library(ROAuth)
library(twitteR)
library(tm)
library(dplyr)
library(stringr)
library(shiny)
library(shinydashboard)
library(httr)
api_key <- "0M9NThScHHmsob0exvG3mlE3h"
api_secret <- "B9t5vKGUnb0AYG0wMS7uElVHSqxwVEgcFDFFAxrn0ciNceda8x"

Access_token <- "760746240384573441-voYzfMnriPYrb6e54DKulr5BiJtJF95"
Acess_token_secret <- "ZtZzSr6wgmsA6KqyDuXMrGH1qgT5b4uUX1jqs8soeSBP7"
setup_twitter_oauth(api_key,api_secret,Access_token,Acess_token_secret)

tweets <- searchTwitter("#brexit",n=10000,since = "2016-06-23",lang="en",geocode = "51.5074,0.1278,80mi") 
tweets_txt = sapply(tweets,function(x) x$getText())
some_txt = gsub('(RT|via)((?:\\b\\W*@\\w+)+)', '', tweets_txt)
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


tweets_harvest.df <- do.call("rbind", lapply(some_txt, as.data.frame))
write.table(tweets_harvest.df, file = "MyData.csv",row.names=FALSE, na="",col.names=FALSE, sep=",")