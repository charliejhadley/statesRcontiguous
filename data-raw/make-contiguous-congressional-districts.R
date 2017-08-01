library("sf")
library("tidyverse")

## ================= Obtain data-rich shapefiles from TIGER

current_congressional_districts_info_url <- read_csv("data-raw/current_congressional_districts_info_url.csv")
download.file(url = current_congressional_districts_info_url$url, destfile = "data-raw/info_congressional-districts.zip")
unzip(zipfile = "data-raw/info_congressional-districts.zip", exdir = "data-raw/info_congressional-districts")
info_us_congressional_districts <- read_sf("data-raw/info_congressional-districts/")
colnames(info_us_congressional_districts)
st_geometry(info_us_congressional_districts) <- NULL
info_us_congressional_districts <- as_tibble(info_us_congressional_districts)
colnames(info_us_congressional_districts)

## ================= Obtain 1:20,000,000 shapefiles from census

current_congressional_districts_shapefile_url <- read_csv("data-raw/current_congressional_districts_shapefile_url.csv")
## Get 1:20,000,000 files
download.file(url = current_congressional_districts_shapefile_url$url, destfile = "data-raw/shapefiles_congressional-districts.zip")
unzip(zipfile = "data-raw/shapefiles_congressional-districts.zip", exdir = "data-raw/shapefiles_congressional-districts")

shp_us_congressional_districts <- read_sf("data-raw/shapefiles_congressional-districts/")

shp_us_congressional_districts <- shp_us_congressional_districts %>%
  full_join(info_us_congressional_districts) %>%
  mutate(STATEFP = as.numeric(STATEFP))

## ================= Combine with FIPS code data

fips_codes <- read_csv("data-raw/US-FIPS-Codes.csv")
shp_us_congressional_districts <- shp_us_congressional_districts %>%
  left_join(fips_codes)

## ================= Combine with data-rich TIGER info

colnames(shp_us_congressional_districts) <- tolower(colnames(shp_us_congressional_districts))

shp_us_congressional_districts <- shp_us_congressional_districts %>%
  rename(
    district.name = namelsad,
    state.fips = statefp,
    state.ns = statens,
    geo.id = geoid,
    congressional.session = cdsessn
  ) %>%
  select(-mtfcc, -funcstat, -intptlat, -intptlon, -cd115fp, -lsad, -aland, -awater) %>%
  select(state.fips, district.name, state.short.name, state.name, state.ns, everything())

## ================= Combine with regions and divisions of states

regions_and_divisions_of_states <- read_csv("data-raw/regions_and_divisions_of_states.csv")

shp_us_congressional_districts <- shp_us_congressional_districts %>%
  left_join(regions_and_divisions_of_states)


# ## ================= Save contiguous only congressional districts
#
# shp_contiguous_us_congressional_districts <- shp_us_congressional_districts %>%
#   filter(contiguous.united.states == TRUE)
#
# save(shp_contiguous_us_congressional_districts, file = "data/shp_contiguous_us_congressional_districts.rdata")

## ================= Save all congressional districts

shp_all_us_congressional_districts <- shp_us_congressional_districts

save(shp_all_us_congressional_districts, file = "data/shp_all_us_congressional_districts.rdata")

## ======================================== Remove files
file.remove("data-raw/info_congressional-districts.zip")
file.remove("data-raw/shapefiles_congressional-districts.zip")
unlink("data-raw/info_congressional-districts", recursive = T)
unlink("data-raw/shapefiles_congressional-districts", recursive = T)

