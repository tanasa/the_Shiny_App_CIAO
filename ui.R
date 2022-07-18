
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

fixedRow(
  br(),
  column(8,
  titlePanel(strong("CIAO (Chromatin Interaction Analysis and Organization) "))),
  
  #br(),
  column(4, offset=6,
  h5(strong("CIAO integrates and displays :")), 
  h5(strong("3C interactions"), "(Hi-C)"),  
  h5(strong("gene annotation tracks"),  "(RefSeq)"), 
  h5(strong("gene expression profiles"), "(GRO-seq)"), 
  h5(strong("chromatin-binding regions"), "(ChIP-seq).")) 
), 
  
br(),
fluidRow(column(6, uiOutput("list_of_panels"))), 
br(),


fluidRow(column(2, wellPanel(
                   radioButtons("genome",
                   label = "Genome assembly",
                   choices = c("hg38", "mm10"), 
                   selected = "mm10")
         )),
      
         
        column(4, wellPanel(
                  helpText("You could upload the file with the interactions in the following format 
                           <chr, start, end, strand, intensity, experiment> :"),  
                  fileInput("file_input", label = h5("")),
                  helpText("or, you could select from available HI-C interaction datasets :"), 
                  selectInput("database",
                               label = "Select an interaction dataset",
                               choices =  c("4D-Genome-database"),
                               selected = "4D-Genome-database") 
                     
         )),
      

        column(2,  wellPanel( 
                   selectInput("chromosome",
                               label = "Select a chromosome",
                               choices =  c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", 
                                            "chr9", "chr10", "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", 
                                            "chr17", "chr18", "chr19", "chr20", "chr21", "chr22", "chrX", "chrY"),
                    selected = "chr19"), 
                   
                   numericInput("start", label = h5(strong("start coordinate")), value = 32582000), 
                   numericInput("end", label = h5(strong("end coordinate")), value = 34338000),
                   sliderInput("intensity", label = h5(strong("Select a range of intensities to display")), min = 0, max = 300, value = c(0, 3000))              
                   
))), 

      
fluidRow(column(3, wellPanel(
                   checkboxGroupInput("DNA_binding", label = h5(strong("Histone marks and transcriptional regulators")),
                        choices = list(  
                                           #"H3K27ac_minusE2" = "MCF7_H3K27ac_minusE2", 
                                           #"H3K27ac_plusE2" = "MCF7_H3K27ac_plusE2"
                                           #"H3K27me3_minusE2" = "MCF7_H3K27me3_minusE2", 
                                           #"H3K27me3_plusE2" = "MCF7_H3K27me3_plusE2", 
                                           #"H3K4me1_minusE2" = "MCF7_H3K4me1_minusE2", 
                                           #"H3K4me1_plusE2" = "MCF7_H3K4me1_plusE2", 
                                           #"H3K4me2_minusE2" = "MCF7_H3K4me2_minusE2",
                                           #"H3K4me2_plusE2" = "MCF7_H3K4me2_plusE2", 
                                           "H3K9me3_minusE2" = "MCF7_H3K9me3_minusE2", 
                                           "H3K9me3_plusE2" = "MCF7_H3K9me3_plusE2"
                                       ), 
                        selected = NULL)
      )), 
        
       column(3, wellPanel(   
                   checkboxGroupInput("gene_expression", label = h5(strong("Regulated coding and non-coding transcripts")),
                         choices = list( "MCF-7  cells: estradiol induced genes" = "MCF7_induced_genes", 
                                         "MCF-7 cells: estradiol repressed genes" = "MCF7_repressed_genes"),
                         selected = NULL)
      )),
      
      column(2, wellPanel( 
                   submitButton("Display")  
  
))), 
    
     
 
# fluidRow(column(4, offset=1,    
#          br(), 
#          img(src = "x.jpg", height = 160, width = 220),
#          br()
#         )),

fluidRow(column(3,   
         br(), 
         h5("."),  
         br()
         ))

))      
