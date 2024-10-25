#### Preamble ####
# Purpose: Downloads and saves the data from fivethirtyeight (https://projects.fivethirtyeight.com/polls/president-general/2024/national/)
# Author: Yunkai Gu & Anqi Xu & Yitong Wang
# Date: October 25 2024
# Contact: kylie.gu@mail.utoronto.ca & anjojoo.xu@mail.utoronto.ca & stevenn.wang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)


#### Download data ####
raw_data <- read_csv("https://projects.fivethirtyeight.com/polls/data/president_polls.csv")


#### Save data ####
write_csv(raw_data, "data/01-raw_data/poll_raw_data.csv") 

         
