#### Preamble ####
# Purpose: Cleans the raw poll dataset
# Author: Yunkai Gu & Anqi Xu & Yitong Wang
# Date: 22 October 2024
# Contact: kylie.gu@mail.utoronto.ca & anjojoo.xu@mail.utoronto.ca & stevenn.wang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Downloaded raw dataset from https://projects.fivethirtyeight.com/polls/president-general/2024/national/
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)


#### Clean data ####
raw_data <- read_csv("data/01-raw_data/poll_raw_data.csv")

cleaned_data <-
  raw_data |>
  filter(numeric_grade >= 2.9) |> 
  # filter only the high-quality pollsters
  mutate(hypothetical = ifelse(hypothetical == "TRUE", 1, 0)) |> 
  # convert binary variable hypothesis into value 1 and 0
  select(pollster, transparency_score, state, sample_size, hypothetical, 
         candidate_name, pct) |> 
  # select columns needed for analysis
  filter(candidate_name == "Kamala Harris" | candidate_name == "Donald Trump" 
         | candidate_name == "Donald Trump Jr.") |>
  # select target candidate
  tidyr::drop_na()


#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/poll_analysis_data.csv")
