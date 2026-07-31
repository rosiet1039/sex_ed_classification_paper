#### Preamble ####
# Purpose: This file contains the code to make the API calls on all models
# Author: Rosemarie Topp
# Date: 15 July 2026
# Contact: rosie.topp@mail.utoronto.ca
# Pre-requisites: ellmer

# load libraries
library(readr)
library(tidyverse)
library(ellmer)

# load data

sentences <- read_csv("data/sentences.csv")

# pick sample of 200 sentences
set.seed(1039)

samp <- sentences[sample(1:nrow(sentences), 200),]

# create df

llm_data <- data.frame(
  sentences = samp
)

# data generation and collection
n = nrow(samp)
  
  # call gpt-4o-mini and record responses
  responses_gpt_4o_mini <- vector("character", n)
  for (i in 1:n) {
    prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$sentence[i], "'")
    chat <- chat_openai(model = "gpt-4o-mini")
    responses_gpt_4o_mini[i] <- chat$chat(prompt)
  }
  
  llm_data$gpt_4o_mini <- responses_gpt_4o_mini
  
  # call gpt-5.4-mini and record responses
  responses_gpt_5.4_mini <- vector("character", n)
  for (i in 1:n) {
    prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$sentence[i], "'")
    chat <- chat_openai(model = "gpt-5.4-mini")
    responses_gpt_5.4_mini[i] <- chat$chat(prompt)
  }
  
  llm_data$gpt_5.4_mini <- responses_gpt_5.4_mini
  
  # call gpt-5.4-mini and record responses
  responses_gpt_4 <- vector("character", n)
  for (i in 1:n) {
    prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$sentence[i], "'")
    chat <- chat_openai(model = "gpt-4")
    responses_gpt_4[i] <- chat$chat(prompt)
  }
  
  llm_data$gpt_4 <- responses_gpt_4
  
  # call claude-sonnet-4-6 and record responses
  #for (i in 1:n) {
  #  prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$sentence[i], "'")
  #  chat <- chat_anthropic(model = "claude-sonnet-4-6")
  #  responses[i] <- chat$chat(prompt)
  #}
  
  #llm_data$claude_sonnet_4_6 <- responses
  
  # call claude-haiku-4-5 and record responses
  #for (i in 1:n) {
  #  prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$sentence[i], "'")
  #  chat <- chat_anthropic(model = "claude-haiku-4-5-20251001")
  #  responses[i] <- chat$chat(prompt)
  #}
  
  #llm_data$claude_haiku_4_5 <- responses
  
  #write responses into csv
  write_csv(llm_data, "data/response_data.csv")

  