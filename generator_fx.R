set.seed(3)
# options(mc.cores=1)
# samplingsize<-0.001 # set percent of corpora to sample
badtext<-readLines(fl[1],encoding="UTF-8")
SPC<-function(x,samplingsize=0.01) { # sample and process corpora
  x<-sample(x,round(samplingsize*length(x)))
  x<-VCorpus(VectorSource(x))
  x<-tm_map(x,removeNumbers)
  x<-tm_map(x,removeWords, stopwords("english"))
  x<-tm_map(x,removeWords, badtext)
  x<-tm_map(x,stripWhitespace)
  x<-tm_map(x, content_transformer(tolower))
  #x<-tm_map(x, content_transformer(str_replace_all("([í½í~])","")))
  x<-tm_map(x, removePunctuation,preserve_intra_word_dashes = TRUE)
}


UniToken<-function(x)NGramTokenizer(x, Weka_control(min = 1, max = 1))
BiToken<-function(x)NGramTokenizer(x, Weka_control(min = 2, max = 2))
TriToken<-function(x)NGramTokenizer(x, Weka_control(min = 3, max = 3))
unigrams<-function(x)
{tdm <- TermDocumentMatrix(x, control = list(tokenize = UniToken))
 fm <- rowSums(as.matrix(tdm))
 ngram<-data.frame(ngram=names(fm),freq=fm)
 ngram<-ngram[order(-ngram$freq),]
}
bigrams<-function(x)
{tdm <- TermDocumentMatrix(x, control = list(tokenize = BiToken))
 fm <- rowSums(as.matrix(tdm))
 ngram<-data.frame(ngram=names(fm),freq=fm)
 ngram<-ngram[order(-ngram$freq),]
}
trigrams<-function(x)
{tdm <- TermDocumentMatrix(x, control = list(tokenize = TriToken))
 fm <- rowSums(as.matrix(tdm))
 ngram<-data.frame(ngram=names(fm),freq=fm)
 ngram<-ngram[order(-ngram$freq),]
}

cleaninput <- function(x) {
   # clean up string
  x <- gsub("\\d+",         "", x, perl = TRUE)
  x <- gsub("[^\\w\\s'#]+", "", x, perl = TRUE)
  x <- gsub("(['#])\\1", "\\1", x, perl = TRUE)
  X <- gsub("_+",           "", x, perl = TRUE)
  x <- gsub("\\s+",        " ", x, perl = TRUE)
  x <- gsub("[^[:alnum:]-\\s]", "", x, perl = TRUE)
  x <- tolower(x)
  all_words <- unlist(strsplit(x, "\\s+"))
}

# extract last 3 words
wordextract <- function(x) {
  a<-length(x)
  b<-x[(a-1):a]
  x<-paste(b,collapse=" ")
}


# remove words we don't have in our dictionary
  words_idx <- vector(mode="list")
  for (num in length(all_words):1) {
    word_idx <- match(all_words[num], t(dat$words))
    print(paste("word idx:", word_idx, " -> ", all_words[num]))
    if (!is.na(word_idx)) words_idx <- c(word_idx, words_idx)
    if (length(words_idx) > 3) return(words_idx)
  }
  
  return(words_idx) # last # words index of the string (we didn't get to 4)
}
