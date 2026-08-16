#### Preamble ####
# Purpose: This file contains the code to make the API calls on all models
# Author: Rosemarie Topp
# Date: 15 July 2026
# Contact: rosie.topp@mail.utoronto.ca
# Pre-requisites: install ellmer package

# load libraries
library(readr)
library(tidyverse)
library(ellmer)

# load data

sentences <- read_csv("data/sentences2.csv")

# separate chapters
#sex_and_gender <- sentences %>% filter(chapter == 1) %>% select(text)
#sexual_reproduction <- sentences %>% filter(chapter == 2) %>% select(text)
#sexual_desire <- sentences %>% filter(chapter == 3) %>% select(text)
#sexual_intercourse <- sentences %>% filter(chapter == 4) %>% select(text)
#slgbt <- sentences %>% filter(chapter == 5) %>% select(text)
#female <- sentences %>% filter(chapter == 7) %>% select(text)
#male <- sentences %>% filter(chapter == 8) %>% select(text)
#words <- sentences %>% filter(chapter == 9) %>% select(text)
#puberty <- sentences %>% filter(chapter == 10) %>% select(text)
#female_puberty <- sentences %>% filter(chapter == 11) %>% select(text)
#male_puberty <- sentences %>% filter(chapter == 12) %>% select(text)
#growing_and_changing <- sentences %>% filter(chapter == 13) %>% select(text)
#taking_care <- sentences %>% filter(chapter == 14) %>% select(text)
#new_feelings <- sentences %>% filter(chapter == 15) %>% select(text)
#masturbation <- sentences %>% filter(chapter == 16) %>% select(text)
#kids <- sentences %>% filter(chapter == 17) %>% select(text)
#genes <- sentences %>% filter(chapter == 18) %>% select(text)
#sharing <- sentences %>% filter(chapter == 19) %>% select(text)
#pregnancy <- sentences %>% filter(chapter == 20) %>% select(text)
#birth <- sentences %>% filter(chapter == 21) %>% select(text)
#other_arrivals <- sentences %>% filter(chapter == 22) %>% select(text)
#planning <- sentences %>% filter(chapter == 23) %>% select(text)
#abortion <- sentences %>% filter(chapter == 24) %>% select(text)
#online <- sentences %>% filter(chapter == 25) %>% select(text)
#abuse <- sentences %>% filter(chapter == 26) %>% select(text)
#stis <- sentences %>% filter(chapter == 27) %>% select(text)
#hiv_aids <- sentences %>% filter(chapter == 28) %>% select(text)
#choices <- sentences %>% filter(chapter == 29) %>% select(text)

# pick sample of 100 sentences
set.seed(1039)

samp <- sentences[sample(1:nrow(sentences), 100),]

# create df

llm_data <- data.frame(
  text = samp$text,
  chapter = samp$chapter
)

# uncomment if adding to data
llm_data <- read.csv("data/response_data.csv")

# data generation and collection
n = nrow(samp)
m = 30
param = params(temperature = 0.4)
  
# call gpt-4o-mini and record responses
  
  #responses_gpt_4o_mini <- vector("character", n)
  #for (i in 1:n) {
  #  output <- ""
  #  for (j in 1:m) {
  #    prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$text[i], "'")
  #    chat <- chat_openai(model = "gpt-4o-mini", params = param)
  #    output <- paste0(output, ",", chat$chat(prompt))
  #  }
  #  responses_gpt_4o_mini[i] <- output
  #}
  
  #llm_data$gpt_4o_mini <- responses_gpt_4o_mini
  
# call gpt-5.4-mini and record responses

  #responses_gpt_5.4_mini <- vector("character", n)
  #for (i in 1:n) {
  #  print(i)
  #  output <- ""
  #  for (j in 1:m) {
  #    prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$text[i], "'")
  #    chat <- chat_openai(model = "gpt-5.4-mini",  params = param)
  #    output <- paste0(output, ",", chat$chat(prompt))
  #  }
  #  responses_gpt_5.4_mini[i] <- output
  #}
  
  #llm_data$gpt_5.4_mini <- responses_gpt_5.4_mini
  
# call gpt-4 and record responses
  #responses_gpt_4 <- vector("character", n)
  #for (i in 1:n) {
  #  print(i)
  #  output <- ""
  #  for (j in 1:m) {
  #    prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$text[i], "'")
  #    chat <- chat_openai(model = "gpt-4", params = param)
  #    output <- paste0(output, ",", chat$chat(prompt))
  #  }
  #  responses_gpt_4[i] <- output
  #}
  
  #llm_data$gpt_4 <- responses_gpt_4

# call deepseek-v4-flash and record responses
  #responses_deepseek_v4_flash <- vector("character", n)
  #for (i in 91:n) {
  #  print(i)
  #  output <- ""
  #  for (j in 1:m) {
  #    prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$text[i], "'")
  #    chat <- chat_deepseek(model = "deepseek-v4-flash", params = param)
  #    output <- paste0(output, ",", chat$chat(prompt))
  #  }
  #  responses_deepseek_v4_flash[i] <- output
  #}

  #llm_data$deepseek_v4_flash <- responses_deepseek_v4_flash

# call deepseek-v4-pro and record responses
  responses_deepseek_v4_pro <- vector("character", n)
  for (i in 1:n) {
    print(i)
    output <- ""
    for (j in 1:m) {
      prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$text[i], "'")
      chat <- chat_deepseek(model = "deepseek-v4-pro", params = param)
      output <- paste0(output, ",", chat$chat(prompt))
    }
    responses_deepseek_v4_pro[i] <- output
  }

llm_data$deepseek_v4_pro <- responses_deepseek_v4_pro
  
# call claude-sonnet-4-6 and record responses
  #for (i in 1:n) {
  #  prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer yes or no ",  "'", samp$text[i], "'")
  #  chat <- chat_anthropic(model = "claude-sonnet-4-6")
  #  responses[i] <- chat$chat(prompt)
  #}
  
  #llm_data$claude_sonnet_4_6 <- responses
  
# call claude-haiku-4-5 and record responses
  responses_claude_haiku_4_5 <- vector("character", n)
  for (i in 1:n) {
    print(i)
    output <- ""
    for (j in 1:m) {
      prompt <- paste0("Is the following text in quotes appropriate for children ages 10 and up? Answer with only yes or no ",  "'", samp$text[i], "'")
      chat <- chat_anthropic(model = "claude-haiku-4-5", params = param)
      output <- paste0(output, ",", chat$chat(prompt))
    }
    responses_claude_haiku_4_5[i] <- output
  }

  llm_data$claude_haiku_4_5 <- responses_claude_haiku_4_5
  
  #write responses into csv
  write_csv(llm_data, "data/response_data.csv")

  