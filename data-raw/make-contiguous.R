library(rgdal)
library(readr)
library(plyr)
library(dplyr)
## Get files
download.file(url = "http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_state_500k.zip", destfile = "data-raw/census-shapefiles.zip")
unzip(zipfile = "data-raw/census-shapefiles.zip", exdir = "data-raw/census-shapefiles")

## Read shapefiles
full_us_shapefiles <- readOGR(dsn = "data-raw/census-shapefiles/", layer = "cb_2015_us_state_500k", verbose = F)
full_us_shapefiles$STATEFP <- as.character(full_us_shapefiles$STATEFP)
full_us_shapefiles$STATEFP <- as.numeric(full_us_shapefiles$STATEFP)

## Load FIPS codes, from https://www2.census.gov/geo/docs/reference/state.txt and annotated by hand
fips_codes <- read_csv("data-raw/US-FIPS-Codes.csv")
make_us_contiguous <- function(spatial_polgyon= NA){
  contiguous_fips_codes <- fips_codes[fips_codes$contiguous.united.states == TRUE,]$fips.code
  contiguous <- full_us_shapefiles[spatial_polgyon$STATEFP %in% contiguous_fips_codes,]
  # Drop unnecessary levels
  contiguous@data <- droplevels(contiguous@data)
  contiguous
}
contiguous_us_shapefiles <- make_us_contiguous(full_us_shapefiles)
contiguous_fips_codes <- fips_codes[fips_codes$contiguous.united.states == TRUE,]
contiguous_us_shapefiles$state.name <- mapvalues(contiguous_us_shapefiles$STATEFP,
                                                 from = contiguous_fips_codes$fips.code,
                                                 to = contiguous_fips_codes$state.name)
## tidy dataframe
colnames(contiguous_us_shapefiles@data) <- tolower(colnames(contiguous_us_shapefiles@data))
contiguous_us_shapefiles@data <- contiguous_us_shapefiles@data %>%
  rename(
    state.fips = statefp,
    state.ns = statens,
    geo.id = geoid,
    a.land = aland,
    a.water = awater,
    aff.geo.id = affgeoid,
    state.short.name = stusps
  )
## Export data
save(contiguous_us_shapefiles, file = "data/contiguous_us_shapefiles.rdata")
## Remove files
file.remove("data-raw/census-shapefiles.zip")
unlink("data-raw/census-shapefiles", recursive = T)



