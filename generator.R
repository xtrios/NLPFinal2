# Generate Corpus

rm(list=ls());gc()
library(stringi); library(dplyr); library(tm); library(RWeka); 
setwd("D:/Dropbox/Coursera/NLPfinal") # set working directory
source("predictor.r"); source("ngraminator.r")
fl<-list.files(".")

blogs<-readLines(fl[1],encoding="UTF-8")
blogs1<-blogs[8001:12000]
blogs2<-uncontract(blogs1)
blogs2<-clean(blogs2)
blogs3<-SCorp(blogs2)
rm(blogs);rm(blogs1);rm(blogs2); gc()
blogs4<-tri(blogs3);
blogs4$ngram<-as.character(blogs4$ngram)
saveRDS(blogs4,"blogs3gram.rds")
rm(blogs3);rm(blogs4);gc()

news<-readLines(fl[2],encoding="UTF-8")
news1<-news[8001:12000]
news2<-uncontract(news1)
news2<-clean(news2)
news3<-SCorp(news2)
rm(news);rm(news1);rm(news2); gc()
news4<-tri(news3);
news4$ngram<-as.character(news4$ngram)
saveRDS(news4,"news3gram.rds")
rm(news3);rm(news4);gc()

twitter<-readLines(fl[3],encoding="latin1")
twitter1<-twitter[12001:18000]
twitter2<-uncontract(twitter1)
twitter2<-clean(twitter2)
twitter3<-SCorp(twitter2)
rm(twitter);rm(twitter1);rm(twitter2); gc()
twitter4<-tri(twitter3);
twitter4$ngram<-as.character(twitter4$ngram)
saveRDS(twitter4,"twitter3gram.rds")
rm(twitter3);rm(twitter4);gc()

# combine 3 grams
blogs3<-readRDS("blogs3gram.rds")
news3<-readRDS("news3gram.rds")
twitter3<-readRDS("twitter3gram.rds")

mergegrams<- function (x,y,z)
{
  x1<-merge.data.frame(x,y,all=TRUE)
  x2<-merge.data.frame(x1,z,all=TRUE)
  x3<-aggregate(freq~ngram, data=x2, sum)
  x3<-x3[order(-x3$freq),]
}

# bigrams<-mergegrams(blogs3,news3,twitter3)
# saveRDS(bigrams,"bigrams_1.rds")
# rm(blogs3);rm(news3);rm(twitter3); gc()

# merge chunks of 2 grams
# bi1<-readRDS("bigrams_1.rds")
# bi2<-readRDS("bigrams_2.rds")
# bi3<-readRDS("bigrams_3.rds")
# bigrams<-mergegrams(bi1,bi2,bi3)
# saveRDS(bigrams,"bigrams_all.rds")


trigrams<-mergegrams(blogs3,news3,twitter3)
saveRDS(trigrams,"trigrams_3.rds")
rm(blogs3);rm(news3);rm(twitter3); gc()

# merge chunks of 3 grams
tri1<-readRDS("trigrams_1.rds")
tri2<-readRDS("trigrams_2.rds")
tri3<-readRDS("trigrams_3.rds")
trigrams<-mergegrams(tri1,tri2,tri3)
saveRDS(trigrams,"trigrams_all.rds")






# mergedocs = full merge doc
# mergedocsA = processed with sampling size of 0.5%
# mergedocsB = sampling size of 0.25%
# mergedocsC = sampling size of 0.1%
# mergedocsD = sampling size of 0.05%

