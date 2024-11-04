#### Preamble ####
# Purpose: Simulates a dataset of American election
# Author: Yunkai Gu & Anqi Xu & Yitong Wang
# Date: 4 NOvember 2024
# Contact: kylie.gu@mail.utoronto.ca & anjojoo.xu@mail.utoronto.ca & stevenn.wang@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(arrow)


#### Simulation preparation ####
# Set seed
set.seed(999)

# Set number of rows in simulation data
n <- 500

# State names
states <- c("Pennsylvania", "North Carolina", "Wisconsin", "South Dakota", "Georgia", 
            "Arizona", "Maryland", "Texas", "Florida", "California", "New Hampshire", 
            "Michigan", "Nevada", "Montana", "Ohio", "Massachusetts", "Nebraska CD-2", 
            "New York", "Virginia", "Missouri", "Indiana", "New Mexico", "Minnesota")


#### Simulate data ####
simulated_data <- tibble(
  #Randomly selected dates within 2024
  end_date = sample(seq(as.Date("2024-05-08"), 
                        as.Date("2024-10-22"), by = "day"), n, replace = TRUE),
  #Random integer between 800 and 1500, similar to the dataset’s range
  sample_size = sample(800:1500, n, replace = TRUE), 
  #Randomly selected from a set of states
  state = sample(states, n, replace = TRUE), 
  #Simulated polling percentage between 45% and 65%
  pct = round(runif(n, 0, 100), 1), 
  end_date_num = 
    as.numeric(end_date - as.Date("2024-05-07")), #Days since May 7, 2024
  #Random integer between 300 and 800, similar as dataset
  num_vote = round(runif(n, 300, 800)) 
)


#### Save data ####
write_parquet(simulated_data, "data/00-simulated_data/poll_simulated_data.parquet")
write_csv(simulated_data, "data/00-simulated_data/poll_simulated_data.csv")