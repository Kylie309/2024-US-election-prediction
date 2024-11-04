#### Preamble ####
# Purpose: Tests the structure and format of election simulation data
# Author: Yunkai Gu & Anqi Xu & Yitong Wang
# Date: 4 November 2024
# Contact: kylie.gu@mail.utoronto.ca & anjojoo.xu@mail.utoronto.ca & stevenn.wang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `tidyverse` `testthat` `arrow` package must be installed and loaded
# - 00-simulate_data.R must have been run



#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

election_data <- read_parquet("data/00-simulated_data/poll_simulated_data.parquet")


#### Test data ####
test_that("simulated data structure is correct", {
  # Test if 'election_data' exists and is a tibble
  expect_true(is_tibble(election_data))
})

test_that("all required columns are present", {
  # Test whether all required columns are present
  required_columns <- c("end_date", "sample_size", "state", 
                        "pct", "end_date_num", "num_vote")
  expect_true(all(required_columns %in% colnames(election_data)))
})

test_that("simulated data columns have correct format", {
  # Check if each column has the correct data type
  expect_true(is.Date(as.Date(election_data$end_date)))  # Convert to Date if necessary
  expect_true(is.numeric(election_data$sample_size))
  expect_true(is.character(election_data$state))
  expect_true(is.numeric(election_data$pct))
  expect_true(is.numeric(election_data$end_date_num))
  expect_true(is.numeric(election_data$num_vote))
})


test_that("end_date column is within proper range", {
  # Test if all 'end_date' values are between May 8, 2024, and Oct 22, 2024
  expect_true(all(as.Date(election_data$end_date) >= as.Date("2024-05-08") &
                    as.Date(election_data$end_date) <= as.Date("2024-10-22")))
})

test_that("end_date_num values are calculated correctly", {
  # Test whether 'end_date_num' corresponds correctly to 'end_date' minus May 7, 2024
  calculated_end_date_num <- as.numeric(as.Date(election_data$end_date) - as.Date("2024-05-07"))
  expect_equal(election_data$end_date_num, calculated_end_date_num)
})

test_that("state values are valid", {
  # Test if 'state' values are within the provided state list
  valid_states <- c("Pennsylvania", "North Carolina", "Wisconsin", 
                    "South Dakota", "Georgia", "Arizona", "Maryland", 
                    "Texas", "Florida", "California", "New Hampshire", 
                    "Michigan", "Nevada", "Montana", "Ohio", "Massachusetts", 
                    "Nebraska CD-2", "New York", "Virginia", "Missouri", 
                    "Indiana", "New Mexico", "Minnesota")
  expect_true(all(election_data$state %in% valid_states))
})
