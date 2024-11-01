# 2024 U.S. Presidential Election Outcome Forecast Using Bayesian Modeling

## Overview

This study aims to forecast the outcome of the 2024 U.S. Presidential Election using aggregated polling data and a Bayesian modeling approach. The study also includes an analysis of a selected pollster’s methodology and an idealized survey design for forecasting elections within a limited budget.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from FiveThirtyEight.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, clean and model data.


## Statement on LLM usage

ChatGPT 4o mini was used to provide assistance on resolving issues occurring in the process of constructing models, and on interpreting and evaluating models. Entire chat history is available in `other/llms/usage.txt`.
