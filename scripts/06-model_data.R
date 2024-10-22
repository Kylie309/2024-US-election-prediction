#### Preamble ####
# Purpose: Models percentage of vote with multiple variables
# Author: Yunkai Gu & Anqi Xu & Yitong Wang
# Date: 22 October 2024
# Contact: kylie.gu@mail.utoronto.ca & anjojoo.xu@mail.utoronto.ca & stevenn.wang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Cleaned the dataset
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(lubridate)
library(broom)
library(modelsummary)
library(rstanarm)
library(splines)


#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/poll_analysis_data.csv")
just_trump_data <- 
  analysis_data |> filter(candidate_name == "Donald Trump" | 
                          candidate_name == "Donald Trump Jr.") |>
  mutate(num_trump = round((pct / 100) * sample_size, 0))


### Starter Models ####

# Model 1: pct as a function of sample size
model_size <-
  lm(pct ~ sample_size, data = just_trump_data)
summary(model_size)

# Model 2: pct as a function of sample size and pollster
model_size_pollster <-
  lm(pct ~ sample_size + pollster,
     data = just_trump_data)
summary(model_size_pollster)

# Augment data with model predictions
just_trump_data <- just_trump_data |>
  mutate(
    fitted_size = predict(model_size),
    fitted_size_pollster = predict(model_size_pollster)
  )

# Model summary
modelsummary(models = list("Model 1" = model_size, 
                           "Model 2" = model_size_pollster))


#### Save model ####
saveRDS(
  model_size,
  file = "models/trump_model_size.rds"
)

saveRDS(
  model_size_pollster,
  file = "models/trump_model_size_pollster.rds"
)
