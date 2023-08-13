library(shiny)
library(shinyjs)
library(dplyr)
library(shinyhelper)
library(Biostrings)
library(seqinr)
clean_seq <- function(sequence_string) {
  cleaned.sequence <- unlist(strsplit(gsub(" ", "", toupper(sequence_string)), ""))
  return(cleaned.sequence)
}


ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "cerulean"),
  titlePanel("Pairwise Sequence Alignment for DNA Sequences "),
  fluidRow(
    column(2, numericInput("matchscore", "Match", value = 2, min = -100, max = 100)),
    column(2, numericInput("mismatchscore", "Mismatch", value = -2, min = -100, max = 100)),
    column(2, numericInput("gapOpening", "Gap Opening", value = -8, min = -100, max = 100)),
    column(2, numericInput("gapExtension", "Gap Extension", value = -2, min = -100, max = 100)),
    column(4, selectInput("pid","Percent Identity Calculation Method",c("PID1","PID2","PID3","PID4"),selected = "PID4"))
  ),
  fluidRow(
    column(6,textAreaInput("seq1", "Sequence 1",placeholder = "Enter the first DNA sequence here" ,width = "100%",rows = 4)), 
    column(6,textAreaInput("seq2", "Sequence 2",placeholder = "Enter the second DNA sequence here" ,width = "100%",rows = 4))
  ),
  fluidRow(
    column(4, offset = 4, align = "center",
           actionButton("calculate", "Align!"))
  ),
  uiOutput("alignmentTitle"),
  verbatimTextOutput("psa"),
  verbatimTextOutput("align"),
  titlePanel("Dot Plot"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("wsize", "Window Size", value = 1, min = 0, max = 100),
      numericInput("wstep", "Window Step", value = 1, min = 0, max = 100),
      numericInput("nmatch", "Number of Matches", value = 1, min = 0, max = 100),
      fluidRow(
        column(7, actionButton("plotbutton", "Plot!")),
        column(
          4,
          conditionalPanel(
            condition = "input.plotbutton> 0",  
            downloadButton("downloadimage", "Download(PNG)")
          )
        )
      ),
      
      
    ),
    mainPanel(
      plotOutput("plot", width = "100%", height = "550px")
    )
  )
)


server <- function(input, output, session) {
  observe_helpers()
  sigma <- eventReactive( input$calculate, {
    nucleotideSubstitutionMatrix(match = input$matchscore, 
                                 mismatch = input$mismatchscore, 
                                 baseOnly = TRUE)
    
  })
  output$psa <- renderText({
    paste(
      "Pattern: ", alignment()@pattern,
      "\nSubject: ", alignment()@subject
    )
  })
  
  
  alignment <-  eventReactive(input$calculate, 
                              {pairwiseAlignment(DNAString(toupper(gsub(" ", "", input$seq1))),DNAString(toupper(gsub(" ", "", input$seq2))) ,substitutionMatrix = sigma(), 
                                                 gapOpening = input$gapOpening,
                                                 gapExtension =input$gapExtension , 
                                                 scoreOnly = FALSE)})
  percentage_identity <-  eventReactive(input$calculate, { pid(alignment(), type= input$pid)})
  output$alignmentTitle <- renderUI({
    req(input$calculate)  
    titlePanel("Alignment Results")%>% 
      helper(icon = "question",
             colour = "green",
             type = "inline",
             content = "For simplicity, only the conserved regions and gaps that are located within the sequences themselves are shown. Any gaps occurring at the beginning or end of sequences will not be shown!")
  })
  
  output$align <- renderText({
    paste("Alignment Score:",alignment()@score,"\nPercentage Identity:", percentage_identity(),"%","\nSequence 1 length:",nchar(gsub(" ", "", input$seq1)),"\nSequence 2 length:",nchar(gsub(" ", "", input$seq2)) )
  })
  
  plot_data <- eventReactive(input$plotbutton, {
    dotPlot(clean_seq(input$seq1), clean_seq(input$seq2), 
            wsize = input$wsize, wstep = input$wstep, nmatch = input$nmatch,xlab ="Sequence1" ,ylab = "Sequence2")
  })
  output$plot <- renderPlot({
    plot_data()
  })
  output$downloadimage <- downloadHandler(
    filename = function() {
      "dotplot.png"
    },
    content = function(file) {
      png(file, width = 800, height = 600)
      dotPlot(clean_seq(input$seq1), clean_seq(input$seq2), 
              wsize = input$wsize, wstep = input$wstep, nmatch = input$nmatch,xlab ="Sequence1" ,ylab = "Sequence2")
      dev.off()
    }
  )
  
}

shinyApp(ui, server)
