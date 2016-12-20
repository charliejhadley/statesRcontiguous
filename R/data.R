#' Contiguous US Shapefiles
#'
#' A SpatialPolygonsDataFrame representing the contiguous United States of America with 500k = 1:500,000 resolution, from www.census.gov.
#'
#' @format A large SpatialPolygonsDataFrame (49 elements, 3.7Mb), an internal data.frame called "data" is available with the following information:
#' \describe{
#'   \item{state.fp}{STATEFP, State FIP code}
#'   \item{state.ns}{GNIS ID for State}
#'   \item{state.short.name}{Two-character short name for state}
#'   \item{state.name}{State name}
#'   \item{a.land}{Area of state that is land}
#'   \item{a.water}{Area of state that is water}
#' }
#' @source \url{https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html}
"contiguous_us_spdf"

#' FIPS Codes
#'
#' A DataFrame containing the FIPS codes for states, taken from https://www.census.gov/geo/reference/codes/cou.html. Whether a State is included in the contiguous United States or not was entered by hand, raise issues in the issue tracker if there are any disagreements.
#'
#' @format A DataFrame (57 rows, 5 columns) with the following data:
#' \describe{
#'   \item{fips.code}{State FIP code}
#'   \item{state.short.name}{Two-character short name for state}
#'   \item{state.name}{State name}
#'   \item{state.ns}{GNIS ID for State}
#'   \item{contiguous.united.states}{Member of contiguous United States or note (TRUE or FALSE)}
#' }
#' @source \url{https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html}
"fips_codes"
