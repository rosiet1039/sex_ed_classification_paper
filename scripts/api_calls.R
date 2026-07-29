#### Preamble ####
# Purpose: This file contains the code to make the API calls on all models
# Author: Rosemarie Topp
# Date: 15 July 2026
# Contact: rosie.topp@mail.utoronto.ca
# Pre-requisites: ellmer

# load libraries
library(readr)

library(ellmer)

# load data

sentences <- read_csv("data/sentences.csv")

# keys

  # openai
  Sys.setenv(OPENAI_API_KEY = "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")

  # google gemini

  # deepseek

  # anthropic

# pick sample of 50 sentences

samp <- sentences[sample(1:nrow(sentences), 10),]

# create df

llm_data <- data.frame(
  sentences = samp
)

# data generation and collection
n = nrow(samp)
responses <- vector("character", n)
  
  # call gpt-4o-mini and record responses
  for (i in 1:n) {
    prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$sentence[i], "'")
    chat <- chat_openai(model = "gpt-4o-mini")
    responses[i] <- chat$chat(prompt)
  }
  
  llm_data$gpt_4o_mini <- responses
  
  # call gpt-5.4-mini and record responses
  for (i in 1:n) {
    prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$sentence[i], "'")
    chat <- chat_openai(model = "gpt-5.4-mini")
    responses[i] <- chat$chat(prompt)
  }
  
  llm_data$gpt_5.4_mini <- responses
  
  #write responses into csv
  write_csv(llm_data, "data/response_data.csv")
