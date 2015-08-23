---
title       : Natural Language Processing App
subtitle    : Coursera-Swiftkey Data Science Capstone Project (Jul 2015)
author      : Shawn Tan
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [rCharts]            # {mathjax, quiz, bootstrap}
ext_widgets  : {rCharts: [libraries/nvd3]}
mode        : selfcontained # {standalone, draft}
---

## Background & Features

<ul>
<li> With the massive amount of information conveyed through various media channels such as blogs, news and twitter, natural language processing has become critical for analysis and prediction with such data sources.</li>
<li> The app serves to provide text prediction based on natural language datasets from various sources.</li>
<li> The data sources were sampled, processed, and used to generate ngrams.</li>
<li> The ngrams were used to build up a prediction model and framework for the app.</li>
</ul>

<div style='text-align: center;'>
    <img height='250' src='process.png' />
</div>


--- .class #id 

## Building ngram Libraries

To generate the bi-gram and tri-gram libraries within the constraints of limited processing power, the corpus was sampled in multiple chunks, and corresponding ngrams were generate from these chunks. The ngrams were merged and sorted based on frequency for a master bi-gram (~563k observations) and tri-gram (~853k observations) library to be used for prediction.

<div style='text-align: center;'>
    <img height='300' src='ngramlib.png' />
</div>

---


## How the App Works

The app takes in two inputs:
<ol>
<li> An <i>input phrase</i> in a text box</li>
<li> The <i>number of predictions to be generated</i> in the form of a slider widget</li></ol>
The input phrase is cleaned up and the last couple of words are used to cross-reference a bi-gram and a tri-gram library.
<ul>
<li> For multiple word input, the trigram library is searched. If no match is found, or if input is a single word, the bigram library is searched. </li> </ul>


---


## Overview of Algorithm

<div style='text-align: center;'>
    <img height='500' src='algorithm.png' />
</div>


---


## Source Codes and Supplementary Information

The source code for this project can be found at the following links:

- Github repository: https://github.com/xtrios/DDP
- Shiny app for mtcars visualization: http://xtrios.shinyapps.io/DDP-mtcars
- Location of Slidify deck: http://xtrios.github.io

Try out the app now at: https://github.com/xtrios/DDP!


