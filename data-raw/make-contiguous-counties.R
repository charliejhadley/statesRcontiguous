library("sf")
library("tidyverse")

## ================= Obtain data-rich shapefiles from TIGER

current_counties_info_url <-
  read_csv("data-raw/current_counties_info_url.csv")
download.file(url = current_counties_info_url$url, destfile = "data-raw/info_counties.zip")
unzip(zipfile = "data-raw/info_counties.zip", exdir = "data-raw/info_counties")
info_us_counties <- read_sf("data-raw/info_counties/")
colnames(info_us_counties)
st_geometry(info_us_counties) <- NULL
info_us_counties <- as_tibble(info_us_counties)
colnames(info_us_counties)

## ================= Obtain 1:20,000,000 shapefiles from census

current_counties_shapefile_url <-
  read_csv("data-raw/current_counties_shapefile_url.csv")
## Get 1:20,000,000 files
download.file(url = current_counties_shapefile_url$url, destfile = "data-raw/shapefiles_counties.zip")
unzip(zipfile = "data-raw/shapefiles_counties.zip", exdir = "data-raw/shapefiles_counties")

shp_us_counties <- read_sf("data-raw/shapefiles_counties/")

shp_us_counties <- shp_us_counties %>%
  full_join(info_us_counties) %>%
  mutate(STATEFP = as.numeric(STATEFP))

## ================= Combine with FIPS code data

fips_codes <- read_csv("data-raw/US-FIPS-Codes.csv")
shp_us_counties <- shp_us_counties %>%
  left_join(fips_codes)

## ================= Combine with data-rich TIGER info

colnames(shp_us_counties) <- tolower(colnames(shp_us_counties))

shp_us_counties <- shp_us_counties %>%
  rename(
    county.name = namelsad,
    county.abbreviated = name,
    county.fp = countyfp,
    county.ns = countyns,
    state.fips = statefp,
    state.ns = statens,
    geo.id = geoid
  ) %>%
  select(
    -mtfcc,
    -funcstat,
    -intptlat,
    -intptlon,
    -awater,
    -aland,
    -metdivfp,
    -cbsafp,
    -csafp,
    -classfp,
    -lsad
  ) %>%
  select(
    county.name,
    county.abbreviated,
    county.fp,
    county.ns,
    state.fips,
    state.short.name,
    state.name,
    state.ns,
    everything()
  )

## ================= Combine with regions and divisions of states

regions_and_divisions_of_states <-
  read_csv("data-raw/regions_and_divisions_of_states.csv")

shp_us_counties <- shp_us_counties %>%
  left_join(regions_and_divisions_of_states)

# ## ================= Save contiguous only counties
#
# shp_contiguous_us_counties <- shp_us_counties %>%
#   filter(contiguous.united.states == TRUE)
#
# save(shp_contiguous_us_counties, file = "data/shp_contiguous_us_counties.rdata")

## ================= Save all counties

shp_all_us_counties <- shp_us_counties

save(shp_all_us_counties, file = "data/shp_all_us_counties.rdata")

## ======================================== Remove files
file.remove("data-raw/info_counties.zip")
file.remove("data-raw/shapefiles_counties.zip")
unlink("data-raw/info_counties", recursive = T)
unlink("data-raw/shapefiles_counties", recursive = T)
