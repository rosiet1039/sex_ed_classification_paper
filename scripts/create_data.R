#### Preamble ####
# Purpose: This file contains the code to create the sex ed dataset
# Author: Rosemarie Topp
# Date: 15 July 2026
# Contact: rosie.topp@mail.utoronto.ca
# Pre-requisites:

# loading libraries
#install.packages("pdftools")
#install.packages("tokenizers")
library(pdftools)
library(tokenizers)

# turning book into text file (only chapters included)
text <- pdf_text("data/its_perfectly_normal.pdf")[7:97]

# collapsing into one string
collapsed <- paste(text, collapse = " ")

# dividing text into sentences
sentences <- tokenize_sentences(collapsed)[[1]]
