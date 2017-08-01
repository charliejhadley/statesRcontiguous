library("sf")
library("tidyverse")

## ================= Obtain data-rich shapefiles from TIGER

current_states_info_url <- read_csv("data-raw/current_states_info_url.csv")
download.file(url = current_states_info_url$url, destfile = "data-raw/info_states.zip")
unzip(zipfile = "data-raw/info_states.zip", exdir = "data-raw/info_states")
regions_and_divisions_of_states <- read_sf("data-raw/info_states/")
colnames(regions_and_divisions_of_states)
st_geometry(regions_and_divisions_of_states) <- NULL
regions_and_divisions_of_states <- as_tibble(regions_and_divisions_of_states)
colnames(regions_and_divisions_of_states) <- tolower(colnames(regions_and_divisions_of_states))

regions_and_divisions_of_states <- regions_and_divisions_of_states %>%
  mutate(state.region = as.integer(region),
         state.division = as.integer(division),
         state.name = name,
         state.ns = statens) %>%
  select(state.region, state.division, state.name,state.ns)

## ================= Combine with regions and divisions into data/

state_regions <- read_csv("data-raw/state-regions.csv")
state_divisions <- read_csv("data-raw/state-divisions.csv")

regions_and_divisions_of_states <- regions_and_divisions_of_states %>%
  mutate(state.division = plyr::mapvalues(state.division, from = state_divisions$division.number, to = state_divisions$division.name, warn_missing = FALSE)) %>%
  mutate(state.region = plyr::mapvalues(state.region, from = state_regions$region.number, to = state_regions$region.name, warn_missing = FALSE))

regions_and_divisions_of_states %>%
  write_csv("data-raw/regions_and_divisions_of_states.csv")

## ======================================== Remove files

file.remove("data-raw/info_states.zip")
unlink("data-raw/info_states", recursive = T)

