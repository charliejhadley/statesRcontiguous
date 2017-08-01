library("sf")
library("tidyverse")

## ================= Obtain data-rich shapefiles from TIGER

current_states_info_url <- read_csv("data-raw/current_states_info_url.csv")
download.file(url = current_states_info_url$url, destfile = "data-raw/info_states.zip")
unzip(zipfile = "data-raw/info_states.zip", exdir = "data-raw/info_states")
info_us_states <- read_sf("data-raw/info_states/")
colnames(info_us_states)
st_geometry(info_us_states) <- NULL
info_us_states <- as_tibble(info_us_states)
colnames(info_us_states)

## ================= Obtain 1:5,000,000 shapefiles from census

current_us_states_shapefile_url <- read_csv("data-raw/current_states_shapefile_url.csv")
## Get 1:20,000,000 files
download.file(url = current_us_states_shapefile_url$url, destfile = "data-raw/shapefiles_us_states.zip")
unzip(zipfile = "data-raw/shapefiles_us_states.zip", exdir = "data-raw/shapefiles_us_states")

shp_us_states <- read_sf("data-raw/shapefiles_us_states/")

shp_us_states <- shp_us_states %>%
  full_join(info_us_states) %>%
  mutate(STATEFP = as.numeric(STATEFP))

## ================= Combine with FIPS code data

fips_codes <- read_csv("data-raw/US-FIPS-Codes.csv")
shp_us_states <- shp_us_states %>%
  left_join(fips_codes)

## ================= Combine with data-rich TIGER info

colnames(shp_us_states) <- tolower(colnames(shp_us_states))

shp_us_states <- shp_us_states %>%
  rename(
    state.fips = statefp,
    state.ns = statens,
    geo.id = geoid,
    a.land = aland,
    a.water = awater
  ) %>%
  select(-region, -division) %>%
  select(-mtfcc, -funcstat, -intptlon, -lsad, -name, -intptlat) %>%
  select(state.fips, state.short.name, state.name, state.ns, a.land, a.water, everything())

## ================= Combine with regions and divisions of states

regions_and_divisions_of_states <- read_csv("data-raw/regions_and_divisions_of_states.csv")

shp_us_states <- shp_us_states %>%
  left_join(regions_and_divisions_of_states)

# ## ================= Save contiguous only states
#
# shp_contiguous_us_states <- shp_us_states %>%
#   filter(contiguous.united.states == TRUE)
#
# save(shp_contiguous_us_states, file = "data/shp_contiguous_us_states.rdata")

## ================= Save all states

shp_all_us_states <- shp_us_states

save(shp_all_us_states, file = "data/shp_all_us_states.rdata")

## ======================================== Remove files
file.remove("data-raw/info_states.zip")
file.remove("data-raw/shapefiles_us_states.zip")
unlink("data-raw/info_states", recursive = T)
unlink("data-raw/shapefiles_us_states", recursive = T)


