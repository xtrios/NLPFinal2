library(shiny)
shinyUI(navbarPage("Natural Language Prediction",
                   tabPanel("Predict",
                            fluidPage(
                              sidebarLayout(
                                sidebarPanel(
                                  textInput("phrase", "Input Phrase:"),
                                  actionButton("goButton", "Predict!"),
                                  br(),
                                  h5("Enter the phrase that you will need to predict in the input box above."),
                                  br(),
                                  hr(),
                                  sliderInput("count", "Number of Word Suggestions", 
                                              value=1.0, min=1.0, max=4.0, step=1.0),
                                  h5("Select the number of word suggestions you would like to see"),
                                  br(),
                                  hr(),
                                  h6("Built for Coursera-Swiftkey Data Science Capstone (Jul 2015) by Shawn Tan"),
                                  h6("For more information about the author:"),
                                  a(img(src = "linkedin.png", height = 25, width = 25),href="https://sg.linkedin.com/in/shawnjtan"),
                                  a(img(src = "inbox.png", height = 25, width = 25),href="mailto: xtrios@gmail.com"),
                                  br()
                                ),
                                mainPanel(
                                  h3("Natural Language Prediction App"),
                                  h4("Input phrase:"),
                                  verbatimTextOutput("nText1"),
                                  h4("Next Word(s):"),
                                  verbatimTextOutput("nText2"),
                                  br(),
                                  hr(),
                                  h5(strong("About the App")),
                                  h5("This app was developed as part of Coursera's Data Science Specialization capstone project (Jul 2015) in partnership with Swiftkey."),
                                  br(),
                                  h5(strong("Using the App")),
                                  h5("To use the app, enter the phrase you want to predict the next word for. The app extracts the last couple of words of the phrase, runs it through an ngram library and generates the most likely next word. The user can also set how many predictions are generated."),
                                  br(),
                                  h5(strong("Data Source")),
                                  h5("The data is from a corpus called ",a("HC Corpora",href="http://www.corpora.heliohost.org"),", with text from sources such as blogs, news and twitter feeds."),
                                  h5("See the ", a("readme file ",href="http://www.corpora.heliohost.org/aboutcorpus.html"), "for details on the corpora available.")
                                  
                                )
                              )
                            )
                   )
                   ,
                   tabPanel("How It Works",
                            fluidPage(
                              sidebarLayout(
                                sidebarPanel(
                                  h5(strong("How It Works")),
                                  br(),
                                  h5(strong("Behind the Scenes")),
                                  h5("Read, Clean & Generate Corpus"),
                                  h5("Generate Ngrams Library"),
                                  br(),
                                  h5(strong("Live App")),
                                  h5("Process the Input"),
                                  h5("Cross-reference Ngrams"),
                                  h5("Generate Next-Word Prediction"),
                                  br(),
                                  h5(strong("Key Functions Used")),
                                  br(),
                                  br(),
                                  hr(),
                                  h6("Built for Coursera-Swiftkey Data Science Capstone (Jul 2015) by Shawn Tan"),
                                  h6("For more information about the author:"),
                                  a(img(src = "linkedin.png", height = 25, width = 25),href="https://sg.linkedin.com/in/shawnjtan"),
                                  a(img(src = "inbox.png", height = 25, width = 25),href="mailto: xtrios@gmail.com")
                                ),
                                mainPanel(
                                  h3("Understanding the App"),
                                  br(),
                                  h4(strong("Behind the Scenes")),
                                  h5(strong("1. Read, Clean & Generate the Corpus")),
                                  p("The data was read  from blogs, news and twitter sources in english respectively, and was subsequently cleaned using the ",
                                    code("uncontract"), " and ", code("clean"), " functions. Subsequently, using the function ",
                                    code("SCorp"),"several transformations were performed on the data files. The transformations were performed with ",
                                    code("tm_map"), "and included removing numbers, bad words, white space, as well as conversion of text into lowercase. After these transformations, the text was converted into a Corpus."),
                                  p("Exploratory analysis had revealed the text from various sources were too big for the available processing power. 
                                    For this reason, three chunks of each source (blogs, news and twitter) were sampled, cleaned and processed with the above methodologies."),
                                  h5(strong("2. Generate Ngrams Library")),
                                  p("Bigrams and trigrams were generated using the ", code("NGramTokenizer"), "function that was utilized in the ", code("bi"), " and ", code("tri"), " functions.
                                    Due to limited processing power, the ngrams were generated from the three chunks for each source (see above), and subsequently combined using the ",
                                    code("mergegrams"), "function. The ", code("mergegrams"), " function also includes a step where the frequencies for identical ngrams are added up, and the merged file is sorted by highest frequency." ),
                                  br(),
                                  h4(strong("Live App")),
                                  h5(strong("1. Process Input")),
                                  p("There are two different inputs to the app -  one is a text input that takes in the phrase to be predicted, the second is a slider from 1 to 4 that determines the number of predictions to generate.
                                    The text input is first cleaned up using the ", code("uncontract"), " and ", code("clean"), " functions. Given that the text input could be of any length, only the last two words of the cleaned-up input is extracted 
                                    using the ", code("selwords"), " function. If the input text is a single word, the word is used 'as-is' for prediction."),
                                  h5(strong("2. Cross-reference Ngrams")),
                                  p("The cross-referencing is performed using the custom ", code("predict"), " function."),
                                  p("If only a single word was input, the default is to cross-reference the word against the bigram library. The location of the matches are found using ", code("grep"), " and the top 'n' results based on the input slider are extracted from the n-gram library."),
                                  p("If more than two words were in the input phrase, the last two words are first cross-referenced against the trigram library, and the top 'n' matches are returned in decreasing order of frequency. 
                                    In the event that no matches are identified, the last word is extracted for cross-referencing against the bigram library. Likewise, the top 'n' results are returned."),
                                  p("If no matches are obtained, the App returns the feedback that 'No matches were found'."),
                                  h5(strong("3. Generate NextWord Prediction")),
                                  p("The predicted 'n' words are isolated from the input phrase using a ", code("strsplit"), " function, and are output onto the App Interface."),
                                  br(),
                                  h4(strong("Key Functions Used")),
                                  p(code("uncontract"),
                                  "Developed to expand contractions such as 'don't', 'ain't, into 'do not' and 'are not'."),
                                p(code("clean"),
                                  "Removes special characters and retains only alphanumerics."),
                                p(code("SCorp"),
                                  "Processes data file and converts into a corpus."),
                                p(code("selwords"),
                                  "Extracts the last two words for prediction from an input phrase with more than two words."),
                                p(code("uni")," ", code("bi")," ", code("tri"),
                                                 "Generates unigrams, bigrams and trigrams respectively for input corpora."),
                                p(code("mergegrams"),
                                  "Merges multiple chunks of n-grams together and sorts them by frequency, allowing for a 'split-and-combine' strategy to generate larger n-gram libraries."),
                                p(code("predict"),
                                  "Prediction function for cross-referencing processed input with bigrams or trigrams library to generate list of possible next words.")
                              )
                            )
                   )
),
tabPanel("Resources",
         fluidPage(
           sidebarLayout(
             sidebarPanel(
               h5(strong("Important Links")),
               br(),
               hr(),
               h6("Built for Coursera-Swiftkey Data Science Capstone (Jul 2015) by Shawn Tan"),
               h6("For more information about the author:"),
               a(img(src = "linkedin.png", height = 25, width = 25),href="https://sg.linkedin.com/in/shawnjtan"),
               a(img(src = "inbox.png", height = 25, width = 25),href="mailto: xtrios@gmail.com"),
               br()
             ),
             mainPanel(
               h3("Resources and Links"),
               br(),
               a("Github repository",href="http://www.corpora.heliohost.org/aboutcorpus.html"),
               br(),
               a("R-Scripts",href="http://www.corpora.heliohost.org/aboutcorpus.html"),
               br(),
               a(code("predictor.r"),href="http://www.corpora.heliohost.org"),
               br(),
               a(code("ngraminator.r"),href="http://www.corpora.heliohost.org"),
               br(),
               a(code("generator.r"),href="http://www.corpora.heliohost.org")
             )
           )
         ))
))


