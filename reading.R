# http://shiny.rstudio.com

library(shiny)
library(ggplot2)
library(reshape2)
library(biovizBase)
library(rtracklayer)
library(GenomicRanges)
library(GenomicFeatures)
library(BSgenome)
library(Homo.sapiens)
library(Mus.musculus)
library(ggbio)
library(Gviz)

# THE LOGIG is :
# considering "H3K27ac_minusE2" in this file ; 
# in the next file we do find :
#   if ("MCF7_H3K27ac_minusE2" %in% input$DNA_binding)
#                                              {
#                                                list_tracks_for_example <- c(list_tracks, "H3K27ac+E2" = H3K27ac_minusE2_chr_plots)
#                                                list_heights_for_example <- c(list_heights, 0.5)   
#                                              }
# and in the file "ui.R"
# "H3K27ac_minusE2" = "MCF7_H3K27ac_minusE2", 
# "H3K27ac_plusE2" = "MCF7_H3K27ac_plusE2"                                              
# and on the WHITE page :
# there are these  2 tracks :
# H3K27ac_minusE2
# H3K27ac_plusE2
#
H3K27ac_minusE2 <- rtracklayer::import("H3K27ac_minusE2.BED", format = "bed")
H3K27ac_plusE2 <- rtracklayer::import("H3K27ac_plusE2.BED", format = "bed")

H3K9me3_minusE2 <- rtracklayer::import("H3K9me3_minusE2.BED", format = "bed")
H3K9me3_plusE2 <- rtracklayer::import("H3K9me3_plusE2.BED", format = "bed")

H3K27me3_minusE2 <- rtracklayer::import("H3K27me3_minusE2.BED", format = "bed")
H3K27me3_plusE2 <- rtracklayer::import("H3K27me3_plusE2.BED", format = "bed")

H3K4me1_minusE2 <- rtracklayer::import("H3K4me1_minusE2.BED", format = "bed")
H3K4me1_plusE2 <- rtracklayer::import("H3K4me1_plusE2.BED", format = "bed")

H3K4me2_minus2 <- rtracklayer::import("H3K4me2_minusE2.BED", format = "bed")
H3K4me2_plusE2 <- rtracklayer::import("H3K4me2_plusE2.BED", format = "bed")

#H3K27ac_minusE2.BED
#H3K27ac_plusE2.BED
# H3K27me3_minusE2.BED
# H3K27me3_plusE2.BED
# H3K4me1_minusE2.BED
# H3K4me1_plusE2.BED
# H3K4me2_minusE2.BED
# H3K4me2_plusE2.BED
# H3K9me3_minusE2.BED
# H3K9me3_plusE2.BED    
