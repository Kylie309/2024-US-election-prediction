#### Preamble ####
# Purpose: Models percentage of vote with date and state
# Author: Yunkai Gu & Anqi Xu & Yitong Wang
# Date: 25 October 2024
# Contact: kylie.gu@mail.utoronto.ca & anjojoo.xu@mail.utoronto.ca & stevenn.wang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Cleaned the dataset
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(lubridate)
library(broom)
library(modelsummary)
library(rstanarm)
library(splines)
library(arrow)


#### Read data ####
trump_national_data <- read_parquet("data/02-analysis_data/trump_national_data.parquet")
trump_state_data <- read_parquet("data/02-analysis_data/trump_state_data.parquet")


#### Bayesian models and splines ####

# Change 'pollster' and 'state' to factor variables
trump_national_data <- trump_national_data |>
  mutate(
    pollster = factor(pollster),
    state = factor(state)
  )

trump_state_data <- trump_state_data |>
  mutate(
    pollster = factor(pollster),
    state = factor(state)
  )

# Fit Bayesian model with spline for prediction of the whole nation
spline_model_national <- stan_glm(
  pct ~ ns(end_date_num, df = 5), # Change df for the number of "bits" - higher numbers - more "wiggly" - but then need to worry about overfitting.
  data = trump_national_data,
  family = gaussian(),
  prior = normal(0, 5),
  prior_intercept = normal(50, 10),
  seed = 304,
  iter = 2000,
  chains = 4,
  refresh = 0
)

# Fit Bayesian model with spline and state as fixed effect
spline_model_state <- stan_glm(
  pct ~ ns(end_date_num, df = 5) + state,
  data = trump_state_data,
  family = gaussian(),
  prior = normal(0, 5),
  prior_intercept = normal(50, 10),
  seed = 304,
  iter = 2000,
  chains = 4,
  refresh = 0
)


#### Save model ####
saveRDS(
  spline_model_national,
  file = "models/model_national.rds"
)

saveRDS(
  spline_model_state,
  file = "models/model_state.rds"
)