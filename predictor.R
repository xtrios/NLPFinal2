library(stringr)
bigrams<-readRDS("bigrams_all.rds")
trigrams<-readRDS("trigrams_all.rds")

# function to clean the input
uncontract<- function(x){
#     expandContractions 
x <- str_replace_all(x, "won't", "will not") 
x <- str_replace_all(x, "can't", "can not")
x <- str_replace_all(x, "ain't", "are not")
x <- str_replace_all(x, "&", "and")
x <- str_replace_all(x, "n't", " not")
x <- str_replace_all(x, "'ll", " will")
x <- str_replace_all(x, "'re", " are")
x <- str_replace_all(x, "'ve", " have")
x <- str_replace_all(x, "'m", " am")
x <- str_replace_all(x, "it's", "it is")
}

clean <- function(x) {
  # clean up string
  x <- str_replace_all(x,"\\d+",         "")
  x <- str_replace_all(x,"[^\\w\\s'#]+", "")
  x <- str_replace_all(x,"(['#])\\1", "\\1")
  X <- str_replace_all(x,"_+",           "")
  x <- str_replace_all(x,"\\s+",        " ")
  x <- str_replace_all(x,"[^[:alnum:]-\\s]", "")
  x <- tolower(x)
}

#select words for prediction
selwords <- function(x) {
  x <- unlist(strsplit(x, "\\s+"))  # generate word list
  if (length(x)>=2)
    {x <- x[(length(x)-1):length(x)]}
  else {x<-x}
}  

#predict function
predict <-function(x,count=1) { #input text
  x1<-uncontract(x)
  x2<-clean(x1)
  x3<-selwords(x2)
  if (length(x3)==1) ## for a single word input
  {    
    y<-head(grep(paste("^\\<",x3[1],"\\>",sep=""),bigrams$ngram),count)
    y1<-bigrams$ngram[y]
    y2<-gsub(x3,"",y1)
    y3<-unlist(strsplit(y2,"\\s+"))
      }
  else ## for input with 2 words or more 
  {
   y<-head(grep(paste("^\\<",x3[1]," ",x3[2],"\\>",sep=""),trigrams$ngram),count)
   y1<-trigrams$ngram[y]
   y2<-gsub(paste(x3[1]," ",x3[2],sep=""),"",y1)
   y3<-unlist(strsplit(y2,"\\s+"))
      
   if (length(y3)==0) ## no match found in trigrams, try bigrams
   { y4<-head(grep(paste("^\\<",x3[2],"\\>",sep=""),bigrams$ngram),count) 
     y5<-bigrams$ngram[y4]
     y5<-gsub(paste(x3[1]," ",x3[2],sep=""),"",y5)
     y6<-unlist(strsplit(y5,"\\s+"))
     y3<-y6
   }
   else
   {y3}
  if (length(y3)==0) ## no match found in trigrams or bigrams
  {return("No match found. Please try another phrase.")}
  else
  {return(y3)}
}        
}

