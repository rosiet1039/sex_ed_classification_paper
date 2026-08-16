#### Preamble ####
# Purpose: This file contains the code to clean model output data
# Author: Rosemarie Topp
# Date: August 6 2026
# Contact: rosie.topp@mail.utoronto.ca
# Pre-requisites: install tidyverse

# load libraries
library(tidyverse)

# load data
raw <- read_csv("data/response_data.csv")

# loop through rows
n = nrow(raw)

clean <- data.frame(text = raw$text)

for (col in colnames(raw)[3:ncol(raw)]){
  props <- vector("numeric", n)
  for (i in (1:n)) {
    result <- unlist(strsplit(raw[[col]][[i]], split = ","))
    yes <- sum(result %in% c("Yes", "Yes.", "yes"))
    no <- sum(result %in% c("No", "No.", "no"))
    if ((yes + no) != 30) {print(i)}
    props[i] <- no/30
  }
  clean[[col]] <- props
}

write.csv(clean, "data/response_clean.csv")

