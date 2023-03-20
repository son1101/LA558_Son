install.packages(c("tidycensus", "tidyverse"))
library(tidycensus)
library(tidyverse)

census_api_key ('c90e4e526781343d0be1eb22561f2297cd8a36b9', overwrite = TRUE, install = TRUE)

vars <- load_variables(2021, "acs5")

iowa_income <- get_acs(
  geography = "county", 
  variables = "B19013_001", 
  state = "IA", 
  year = 2021, 
  geometry = TRUE)

plot(iowa_income["estimate"])

