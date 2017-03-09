library(rgdal)
library(readr)
library(plyr)
library(dplyr)


## ============= Get names of congressional districts
## The TIGER shapefiles are very large, but contain identifying names of the congressional districts
## A better source surely exists, but this is used to generate names for the small shapefiles used in the actual package
## Run this once and only once
# download.file(url = "ftp://ftp2.census.gov/geo/tiger/TIGER2014/CD/tl_2014_us_cd114.zip", destfile = "data-raw/shapefiles_tiger_congressional-districts.zip")
# unzip(zipfile = "data-raw/shapefiles_tiger_congressional-districts.zip", exdir = "data-raw/shapefiles_tiger_congressional-districts")
#
# tiger_congressional_districts <- readOGR(dsn = "data-raw/shapefiles_tiger_congressional-districts", layer = "tl_2014_us_cd114", verbose = F)
# colnames(tiger_congressional_districts@data) <- tolower(colnames(tiger_congressional_districts@data))
#
# ## Store cd_details for later
# cd_details <- as_data_frame(tiger_congressional_districts@data) %>%
#   filter(!cd114fp == "00") %>% # drop Congressional District (at Large) records
#   select(statefp, geoid, namelsad) %>%
#   mutate(statefp = as.double(statefp))
# write_csv(cd_details, "data-raw/congressional-details.csv")
# ## Remove files
# file.remove("data-raw/shapefiles_tiger_congressional-districts.zip")
# unlink("data-raw/shapefiles_tiger_congressional-districts", recursive = T)




## Get files
download.file(url = "http://www2.census.gov/geo/tiger/GENZ2014/shp/cb_2014_us_cd114_500k.zip", destfile = "data-raw/shapefiles_congressional-districts.zip")
unzip(zipfile = "data-raw/shapefiles_congressional-districts.zip", exdir = "data-raw/shapefiles_congressional-districts")

## Read shapefiles
full_us_congressdistricts_shapefiles <- readOGR(dsn = "data-raw/shapefiles_congressional-districts/", layer = "cb_2014_us_cd114_500k", verbose = F)
colnames(full_us_congressdistricts_shapefiles@data) <- tolower(colnames(full_us_congressdistricts_shapefiles@data))
full_us_congressdistricts_shapefiles$statefp <- as.character(full_us_congressdistricts_shapefiles$statefp)
full_us_congressdistricts_shapefiles$statefp <- as.numeric(full_us_congressdistricts_shapefiles$statefp)


## Load FIPS codes, from https://www2.census.gov/geo/docs/reference/state.txt and annotated by hand
fips_codes <- read_csv("data-raw/US-FIPS-Codes.csv")
make_us_contiguous <- function(spatial_polgyon= NA){
  contiguous_fips_codes <- fips_codes[fips_codes$contiguous.united.states == TRUE,]$fips.code
  contiguous <- spatial_polgyon[spatial_polgyon$statefp %in% contiguous_fips_codes,]
  # Drop unnecessary levels
  contiguous@data <- droplevels(contiguous@data)
  contiguous
}


contiguous_congressional_districts <- make_us_contiguous(full_us_congressdistricts_shapefiles)
contiguous_congressional_districts$state.name <- mapvalues(contiguous_congressional_districts$statefp,
                                                 from = fips_codes$fips.code,
                                                 to = fips_codes$state.name)

## Import congressional-details.csv
cd_details <- as_data_frame(read.csv("data-raw/congressional-details.csv"))
## Combine and generate congressional district name
combined_cd_details <-
  full_join(as_data_frame(contiguous_congressional_districts@data),
            cd_details) %>%
  mutate(name = paste(
    state.name,
    ifelse(is.na(namelsad), "(District name not given)", namelsad)
  ))
## Update shapefile
contiguous_congressional_districts@data <- as.data.frame(combined_cd_details)
## Drop those elements of @data where no cd114
contiguous_congressional_districts <- contiguous_congressional_districts[!is.na(contiguous_congressional_districts$cd114fp),]
## Rename
contiguous_congressional_districts_spdf <- contiguous_congressional_districts
## Export data
save(contiguous_congressional_districts_spdf, file = "data/contiguous_congressional_districts_spdf.rdata")
## Remove files
file.remove("data-raw/shapefiles_congressional-districts.zip")
unlink("data-raw/shapefiles_congressional-districts", recursive = T)
