# 2024 U.S. Presidential Election Outcome Forecast Using Bayesian Modeling

## Overview

This study employs Bayesian modeling to predict the 2024 U.S. presidential election outcomes, and analyzing public support trends for Donald Trump. We using national and state level data to model how Trump’s vote percentage evolves as the election approaches. The model captures temporal and regional patterns in support levels, which revealing a rise in Trump’s favorability, particularly in the pivotal states such as Pennsylvania, Michigan, and Florida. These findings are valuable for campaign strategists and policymakers, providing a detailed understanding of voter motivations and helping anticipate shifts that could affect the election outcome.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from FiveThirtyEight.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains details about LLM chat interactions and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, clean and model data.


## Statement on LLM usage

ChatGPT 4o mini was used to provide assistance on resolving issues occurring in the process of constructing models, and on interpreting and evaluating models. Entire chat history is available in `other/llms/usage.txt`.
