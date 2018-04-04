library("tidyverse")
library("statesRcontiguous")
states_data_file <- read_csv("data-raw/current_states_shapefile_url.csv")
congressional_districts_data_file <- read_csv("data-raw/current_congressional_districts_shapefile_url.csv")
counties_data_file <- read_csv("data-raw/current_counties_shapefile_url.csv")

rmarkdown::render("README.Rmd", params = list(
  states_data_file = states_data_file,
  congressional_districts_data_file = congressional_districts_data_file,
  counties_data_file = counties_data_file
))

unlink("README.html")
