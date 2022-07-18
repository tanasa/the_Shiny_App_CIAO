library("shiny")
options(shiny.maxRequestSize=20*1024^2)
source("reading.R")


shinyServer(function(input, output){
  
            # output$chromosome_selected <- renderText({ input$chromosome })
            # output$chromosome_start <- renderText({ input$start })
            # output$chromosome_end <- renderText({ input$end })
            # output$intensity_interaction <- renderPrint({ paste(input$intensity[1],"and", input$intensity[2])  })
            # output$DNA_binding <- renderPrint({ paste(input$DNA_binding[1],"and", input$DNA_binding[2])  })
          
           interactions_GRanges_reactive <-  reactive({  
                                                         file_input_interactions <- input$file_input
                                                         if (is.null(file_input_interactions)) return(NULL)
                                              
                                                         i <- read.delim(file_input_interactions$datapath, header=TRUE, stringsAsFactors=FALSE)
                                                         interactions_GRanges <- GRanges(seqnames=i$chr,IRanges(i$start,i$end),strand="*",intensity=i$intensity,experiment=i$experiment)
                                                         interactions_GRanges
                                                       })
  
  
            output$plot_region <- renderPlot({ 
                                              
                                           #   file_input_interactions <- input$file_input
                                           #   if (is.null(file_input_interactions)) return(NULL)
              
                                           #  i <- read.delim(file_input_interactions$datapath, header=TRUE, stringsAsFactors=FALSE)
                                           #  interactions_granges <- GRanges(seqnames=i$chr,IRanges(i$start,i$end),strand="*",intensity=i$intensity,experiment=i$experiment)
              
                                              
                                              region <- GRanges(input$chromosome, IRanges(input$start, input$end)) 
                                              interactions_chr <- keepSeqlevels(interactions_GRanges_reactive(), input$chromosome, pruning.mode = "coarse") 
                                                      
                                              hits <- findOverlaps(interactions_chr, region, type = 'within') 
                                              interactions_chr <- interactions_chr[queryHits(hits)] 
          
                                              interactions_chr <- subset(interactions_chr, ( abs(intensity) > input$intensity[1] ) & ( abs(intensity) < input$intensity[2] ) )
                                              
                                              interactions_region <-  autoplot(interactions_chr, geom="arch", aes(col=experiment, height=intensity, alpha = abs(intensity))) + xlim(region) 
                                              gene_region <- autoplot(Homo.sapiens, which = region, color = "blue", fill = "blue", names.expr="SYMBOL")
                                              # gene_region <- autoplot(Mus.musculus, which = region, color = "blue", fill = "blue", names.expr="SYMBOL")
                                              
              
                                              #H3K27ac_minus_chr <- keepSeqlevels(H3K27ac_minusE2, input$chromosome, pruning.mode = "coarse")
                                              #H3K27ac_minus_chr_plots <- autoplot(H3K27ac_minusE2_chr, geom="rect", fill = "purple", color="purple") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 

                                              #H3K27ac_plusE2_chr <- keepSeqlevels(H3K27ac_plusE2, input$chromosome, pruning.mode = "coarse")
                                              #H3K27ac_plusE2_chr_plots <- autoplot(H3K27ac_plusE2_chr, geom="rect", fill = "purple", color="purple") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                              
                                              H3K9me3_minusE2_chr <- keepSeqlevels(H3K9me3_minusE2, input$chromosome, pruning.mode = "coarse")
                                              H3K9me3_minusE2_chr_plots <- autoplot(H3K9me3_minusE2_chr, geom="rect", fill = "purple", color="brown") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                                                                                                                      
                                              H3K9me3_plusE2_chr <- keepSeqlevels(H3K9me3_plusE2, input$chromosome, pruning.mode = "coarse")
                                              H3K9me3_plusE2_chr_plots <- autoplot(H3K9me3_plusE2_chr, geom="rect", fill = "purple", color="brown") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                              
                                              #H3K27me3_minusE2_chr <- keepSeqlevels(H3K27me3_minusE2, input$chromosome, pruning.mode = "coarse")
                                              #H3K27me3_minusE2_chr_plots <- autoplot(H3K27me3_minus2_chr, geom="rect", fill = "purple", color="brown") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                              
                                              #H3K27me3_plusE2_chr <- keepSeqlevels(H3K27me3_plusE2, input$chromosome, pruning.mode = "coarse")
                                              #H3K27me3_plusE2_chr_plots <- autoplot(H3K27me3_plusE2_chr, geom="rect", fill = "purple", color="brown") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                              
                                              #H3K4me1_minusE2_chr <- keepSeqlevels(H3K4me1_minusE2, input$chromosome, pruning.mode = "coarse")
                                              #H3K4me1_minusE2_chr_plots <- autoplot(H3K4me1_minus2_chr, geom="rect", fill = "purple", color="brown") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                              
                                              #H3K4me1_plusE2_chr <- keepSeqlevels(H3K4me1_plusE2, input$chromosome, pruning.mode = "coarse")
                                              #H3K4me1_plusE2_chr_plots <- autoplot(H3K4me1_plus2_chr, geom="rect", fill = "purple", color="brown") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                              
                                              #H3K4me2_minusE2_chr <- keepSeqlevels(H3K4me2_minusE2, input$chromosome, pruning.mode = "coarse")
                                              #H3K4me2_minusE2_chr_plots <- autoplot(H3K4me2_minus2_chr, geom="rect", fill = "purple", color="brown") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                              
                                              #H3K4me2_plusE2_chr <- keepSeqlevels(H3K4me2_plusE2, input$chromosome, pruning.mode = "coarse")
                                              #H3K4me2_plusE2_chr_plots <- autoplot(H3K4me2_plus2_chr, geom="rect", fill = "purple", color="brown") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                                                                         
                                              # up_genes_chr <- keepSeqlevels(up_genes, input$chromosome, pruning.mode = "coarse")
                                              # up_genes_chr_plots <- autoplot(up_genes_chr, geom="rect", fill= "orange", col="orange") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                              
                                              # down_genes_chr <- keepSeqlevels(down_genes, input$chromosome, pruning.mode = "coarse")
                                              # down_genes_chr_plots <- autoplot(down_genes_chr, geom="rect", fill= "orange", col="orange") + xlim(region) + scale_x_sequnit() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
                                              
                                          
                                              # all_tracks <- tracks("3C interactions" = interactions_region, "genes" = gene_region, heights= c(4,1)) + xlim(region) + theme(panel.background = element_rect(fill='transparent'))
                                              
                                              list_tracks <- list(interactions_region, "genes" = gene_region)
                                              list_heights <- c(4,4)
                                              

                                              
                                              ############################################################## 
                                              
                                              # if ("MCF-7_H3K4me2_minusE2" %in% input$DNA_binding)
                                              # {      
                                              #  list_tracks <- c(list_tracks, "H3K4me2-E2" = H3K4me2_minusE2_chr_plots)
                                              #  list_heights <- c(list_heights, 0.5)
                                              # }  
                                              
                                              
                                              # if ("MCF-7_H3K4me2_plusE2" %in% input$DNA_binding)
                                              # {      
                                              #  list_tracks <- c(list_tracks, "H3K4me2+E2" = H3K4me2_plusE2_chr_plots)
                                              #  list_heights <- c(list_heights, 0.5)
                                              # }  
                                              
                                              
                                              ############################################################## 
                                              
                                             # if ("MCF-7_H3K4me1_minusE2" %in% input$DNA_binding)
                                             # {      
                                             #   list_tracks <- c(list_tracks, "H3K4me1-E2" = H3K4me1_minusE2_chr_plots)
                                             #   list_heights <- c(list_heights, 0.5)
                                             # }  
                                              
                                              
                                             # if ("MCF-7_H3K4me1_plusE2" %in% input$DNA_binding)
                                             # {      
                                             #   list_tracks <- c(list_tracks, "H3K4me1+E2" = H3K4me1_plusE2_chr_plots)
                                             #   list_heights <- c(list_heights, 0.5)
                                             # }  
                                              
                                            
                                              ############################################################## 
                                              
                                              #if ("MCF7_H3K27ac_minusE2" %in% input$DNA_binding)
                                              #{
                                              #  list_tracks_for_example <- c(list_tracks, "H3K27ac+E2" = H3K27ac_minusE2_chr_plots)
                                              #  list_heights_for_example <- c(list_heights, 0.5)   
                                              #}
                                              
                                              #if ("MCF7_H3K27ac_plusE2" %in% input$DNA_binding)
                                              #{
                                              #  list_tracks_for_example <- c(list_tracks, "H3K27ac+E2" = H3K27ac_plusE2_chr_plots)
                                              #  list_heights_for_example <- c(list_heights, 0.5)   
                                              #}
                                              
                                              ############################################################## 

                                              
                                             if ("MCF7_H3K9me3_minusE2" %in% input$DNA_binding)
                                               {
                                                list_tracks <- c(list_tracks, "H3K9me3-E2" = H3K9me3_minusE2_chr_plots)
                                                list_heights <- c(list_heights, 0.5)   
                                             }
                                                                                           
                                              if ("MCF7_H3K9me3_plusE2" %in% input$DNA_binding)
                                              {
                                                list_tracks <- c(list_tracks, "H3K9me3+E2" = H3K9me3_plusE2_chr_plots)
                                                list_heights <- c(list_heights, 0.5)   
                                              }
                                              
                                              ############################################################## 
                                              
                                              #if ("MCF7_H3K27me3_minusE2" %in% input$DNA_binding)
                                              #{
                                              #list_tracks <- c(list_tracks, "H3K27me3-E2" = H3K27me3_minusE2_chr_plots)
                                              #list_heights <- c(list_heights, 0.5)   
                                              #}
                                              
                                              
                                              #if ("MCF7_H3K27me3_plusE2" %in% input$DNA_binding)
                                              #{
                                              #  list_tracks <- c(list_tracks, "H3K27me3+E2" = H3K27me3_plusE2_chr_plots)
                                              #  list_heights <- c(list_heights, 0.5)   
                                              #}
                                              
                                              
                                              ############################################################## 

                                              
                                              all_tracks <- tracks(list_tracks, heights = list_heights) + xlim(region)  + theme(panel.background = element_rect(fill='transparent')) 
                                              
                                              all_tracks
                                        })
                 
           
           
            output$list_of_panels <- renderUI({
                                                 if(is.null(interactions_GRanges_reactive())) h5("")
                                                 else 
                                                       tabsetPanel(type="tab", 
                                                               tabPanel("Display in LINEAR FORMAT", plotOutput("plot_region")), 
                                                               tabPanel("Display in CIRCULAR FORMAT"), 
                                                               tabPanel("Display the list of interactions", downloadButton("download_list_interactions", label = "Download the list of interactions in the selected region(s)"))  
                                                       )
                                             })
           
           
            
})
