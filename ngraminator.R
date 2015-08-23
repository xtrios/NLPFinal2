library(stringi); library(dplyr); library(tm)
library(RWeka); 
source("predictor.R")
badwords<-readRDS("badwords.rds")

SCorp<-function(x) { # generate corpora
  x<-VCorpus(VectorSource(x))
  x<-tm_map(x,removeNumbers)
#   x<-tm_map(x,removeWords, stopwords("english"))
  x<-tm_map(x,removeWords, badwords)
  x<-tm_map(x,stripWhitespace)
  x<-tm_map(x,content_transformer(tolower))
  x<-tm_map(x,removePunctuation,preserve_intra_word_dashes = TRUE)
}

UniToken<-function(x)NGramTokenizer(x, Weka_control(min = 1, max = 1))
BiToken<-function(x)NGramTokenizer(x, Weka_control(min = 2, max = 2))
TriToken<-function(x)NGramTokenizer(x, Weka_control(min = 3, max = 3))
QuadToken<-function(x)NGramTokenizer(x, Weka_control(min = 4, max = 4))
uni<-function(x)
{tdm <- TermDocumentMatrix(x, control = list(tokenize = UniToken))
 fm <- rowSums(as.matrix(tdm))
 ngram<-data.frame(ngram=names(fm),freq=fm)
 ngram<-ngram[order(-ngram$freq),]
}
bi<-function(x)
{tdm <- TermDocumentMatrix(x, control = list(tokenize = BiToken))
 fm <- rowSums(as.matrix(tdm))
 ngram<-data.frame(ngram=names(fm),freq=fm)
 ngram<-ngram[order(-ngram$freq),]
}
tri<-function(x)
{tdm <- TermDocumentMatrix(x, control = list(tokenize = TriToken))
 fm <- rowSums(as.matrix(tdm))
 ngram<-data.frame(ngram=names(fm),freq=fm)
 ngram<-ngram[order(-ngram$freq),]
}
quad<-function(x)
{tdm <- TermDocumentMatrix(x, control = list(tokenize = QuadToken))
 fm <- rowSums(as.matrix(tdm))
 ngram<-data.frame(ngram=names(fm),freq=fm)
 ngram<-ngram[order(-ngram$freq),]
 ngram$ngram<-as.character(ngram$ngram)
}