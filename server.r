library(shiny)
library(tm)
library(RWeka)
library(stringr)

shinyServer(function(input, output) {
bigrams<-readRDS("bigrams_all.rds")
trigrams<-readRDS("trigrams_all.rds")
setwd("D:/Dropbox/Coursera/NLPfinal") # set working directory
  
  # builds a reactive expression that only invalidates 
  # when the value of input$goButton becomes out of date 
  # (i.e., when the button is pressed)

  
  nText <- eventReactive(input$goButton, {
    input$phrase
  })

  nText2<- eventReactive(input$goButton, {
    x<-input$phrase
    source("predictor.R")
    x<- predict(x,input$count)
  })
  
  output$nText1 <- renderText({
    nText()
  })
 
  output$nText2 <- renderPrint({
    cat(nText2(), sep="\n")
    })
  
})