#' Shapefiles detailing the Congressional Districts of the USA, designed for subsetting to the contiguous USA.
#'
#' An "sf" "data.frame" representing congressional districts of the United States of America with 20m = 1:20,000,000 resolution, from www.census.gov.
#'
#' @format Simple feature collection with 444 features and 12 fields
#' \describe{
#'   \item{state.fips}{State FIP code}
#'   \item{district.name}{Congressional District name}
#'   \item{state.short.name}{Two-character short name for state}
#'   \item{state.name}{State name}
#'   \item{state.ns}{GNIS ID for State}
#'   \item{aff.geo.id}{American Fact Finder Geo ID}
#'   \item{geoid}{Unknown identifier from Census}
#'   \item{congressional.session}{Congressional session (all identical)}
#'   \item{contiguous.united.states}{Is a member of the contiguous US? TRUE/FALSE}
#'   \item{is.state}{Is this Congressional District part of a recognised State? TRUE/ FALSE}
#'   \item{state.region}{Region the parent state belongs to}
#'   \item{state.divison}{Division the parent state belongs to}
#'   \item{geometry}{MULTIPOLYGON, defines the border of the Congressional District}
#' }
#' @source \url{http://www2.census.gov/geo/tiger/GENZ2016/shp/cb_2016_us_cd115_20m.zip}
"shp_all_us_congressional_districts"

#' Shapefiles detailing the Counties of the USA, designed for subsetting to the contiguous USA.
#'
#' An "sf" "data.frame" representing counties of the United States of America with 20m = 1:20,000,000 resolution, from www.census.gov.
#'
#' @format Simple feature collection with 3233 features and 14 fields
#' \describe{
#'   \item{county.name}{County name}
#'   \item{county.name.abbreviated}{Abbreviated or commong county name}
#'   \item{county.fp}{County unique identifier}
#'   \item{county.ns}{GNIS IDfor county}
#'   \item{state.fips}{State FIP code}
#'   \item{state.short.name}{Two-character short name for state}
#'   \item{state.name}{State name}
#'   \item{state.ns}{GNIS ID for State}
#'   \item{aff.geo.id}{American Fact Finder Geo ID}
#'   \item{geoid}{Unknown identifier from Census}
#'   \item{congressional.session}{Congressional session (all identical)}
#'   \item{contiguous.united.states}{Is a member of the contiguous US? TRUE/FALSE}
#'   \item{is.state}{Is this Congressional District part of a recognised State? TRUE/ FALSE}
#'   \item{state.region}{Region the parent state belongs to}
#'   \item{state.divison}{Division the parent state belongs to}
#'   \item{geometry}{MULTIPOLYGON, defines the border of the Congressional District}
#' }
#' @source \url{http://www2.census.gov/geo/tiger/GENZ2016/shp/cb_2016_us_cd115_20m.zip}
"shp_all_us_counties"

#' Shapefiles detailing the states of the USA, designed for subsetting to the contiguous USA.
#'
#' An "sf" "data.frame" representing counties of the United States of America with 20m = 1:20,000,000 resolution, from www.census.gov.
#'
#' @format Simple feature collection with 56 features and 14 fields
#' \describe{
#'   \item{state.fips}{State FIP code}
#'   \item{state.short.name}{Two-character short name for state}
#'   \item{state.name}{State name}
#'   \item{state.ns}{GNIS ID for State}
#'   \item{a.land}{Area of state that is land, m2}
#'   \item{a.water}{Area of state that is water, m2}
#'   \item{aff.geo.id}{American Fact Finder Geo ID}
#'   \item{geoid}{Unknown identifier from Census}
#'   \item{congressional.session}{Congressional session (all identical)}
#'   \item{contiguous.united.states}{Is a member of the contiguous US? TRUE/FALSE}
#'   \item{is.state}{Is this Congressional District part of a recognised State? TRUE/ FALSE}
#'   \item{state.region}{Region the parent state belongs to}
#'   \item{state.divison}{Division the parent state belongs to}
#'   \item{geometry}{MULTIPOLYGON, defines the border of the Congressional District}
#' }
#' @source \url{http://www2.census.gov/geo/tiger/GENZ2016/shp/cb_2016_us_county_20m.zip}
"shp_all_us_states"

#' Details of the shapefiles included in this package.
#'
#' A tibble containing the url, year and description of all shapefiles used to create the datasets included in this package
#'
#' @format A tibble containing 6 rows and 3 variables.
#' \describe{
#'     \item{description}{What is this shapefile used for?}
#'     \item{year}{Year of observation (i.e. congressional districts for 2016)}
#'     \item{url}{URL for the shapefile zip file}
#' }
#' @source \url{http://www2.census.gov/geo/tiger/GENZ2016/shp/cb_2016_us_state_20m.zip}
"shapefile_details"

