library("sf")
library("tidyverse")

detailed_congressional_districts_url <- read_csv("data-raw/current_congressional_districts_info_url.csv") %>%
  mutate(description = "Details about congressional districts")
detailed_counties_url <- read_csv("data-raw/current_counties_info_url.csv") %>%
  mutate(description = "Details about counties")
detailed_states_url <- read_csv("data-raw/current_states_info_url.csv") %>%
  mutate(description = "Details about states")

shapefiles_congressional_districts_url <- read_csv("data-raw/current_congressional_districts_shapefile_url.csv") %>%
  mutate(description = "Shapefile for congressional districts")
shapefiles_counties_url <- read_csv("data-raw/current_counties_shapefile_url.csv") %>%
  mutate(description = "Shapefile for counties")
shapefiles_states_url <- read_csv("data-raw/current_states_shapefile_url.csv") %>%
  mutate(description = "Shapefile for states")


shapefile_details <- detailed_congressional_districts_url %>%
  bind_rows(detailed_counties_url) %>%
  bind_rows(detailed_states_url) %>%
  bind_rows(shapefiles_congressional_districts_url) %>%
  bind_rows(shapefiles_counties_url) %>%
  bind_rows(shapefiles_states_url) %>%
  select(description, year, url)

save(shapefile_details, file = "data/shapefile_details.rdata")
