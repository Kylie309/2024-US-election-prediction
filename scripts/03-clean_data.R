#### Preamble ####
# Purpose: Cleans the raw poll dataset
# Author: Yunkai Gu & Anqi Xu & Yitong Wang
# Date: 4 November 2024
# Contact: kylie.gu@mail.utoronto.ca & anjojoo.xu@mail.utoronto.ca & stevenn.wang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Downloaded raw data from fivethirtyeight
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(lubridate)
library(arrow)


#### Clean data ####
raw_data <- read_csv("data/01-raw_data/poll_raw_data.csv")

# Clean the data for prediction of the whole nation
national_data <- 
  raw_data |>
  # filter only the high-quality pollsters
  filter(numeric_grade >= 2.9,
         # filter target candidate
         candidate_name == "Donald Trump" 
         | candidate_name == "Donald Trump Jr.") |> 
  # obtain end date of the polls
  mutate(end_date = mdy(end_date)) |>
  # choose data during half a year before the election (Nov 5, 2024)
  filter(end_date >= as.Date("2024-05-05")) |> 
  # select columns needed for analysis
  select(end_date, sample_size, state, pct) |>
  # change date to be number of days since half year ago - it's a counter not a date
  mutate(end_date_num = as.numeric(end_date - min(end_date))) |>
  # need vote in number not percent for some models
  mutate(num_vote = round((pct / 100) * sample_size, 0))

# Remove all missing values to clean data for prediction of each state
state_data <-
  national_data |> tidyr::drop_na()


#### Save data ####
write_parquet(national_data, "data/02-analysis_data/trump_national_data.parquet")
write_parquet(state_data, "data/02-analysis_data/trump_state_data.parquet")
