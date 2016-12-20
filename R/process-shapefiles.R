#' get_shape_files
#'
#' \code{get_us_shape_files} downloads shapefiles from census.gov
#'
#' @param resolution Resolution of the requested shapefiles, may only be "500k", "5m", or "20m". Default to "500k"
#' @param year Year for which the shapefiles should be requested, may only be 2013, 2014, or 2015. Default to 2015
#' @param zip.path Path for zip file downloaded from census.gov, default to shapefiles.zip in the working directory.
#' @param shapefiles.path Path for shapefiles to be unzipped, default to shapefiles/
#' @param delete.zip Delete zip or not, default to TRUE.
#'
#' @export
get_us_shape_files <- function(resolution = "500k",
                               year = "2015",
                               zip.path = "shapefiles.zip",
                               shapefiles.path = "shapefiles/",
                               delete.zip = TRUE) {
  if (is.na(match(resolution, c("500k", "5m", "20m")))) {
    stop("Resolution must be 500k, 5m or 20m")
  }

  if (is.na(match(year, c("2015", "2014", "2013")))) {
    stop("Year must be 2015, 2014 or 2013")
  }

  utils::download.file(
    url = paste0(
      "http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_",
      year,
      "_us_state_",
      resolution,
      ".zip"
    ),
    destfile = file.path(getwd(), zip.path)
  )
  utils::unzip(zipfile = file.path(getwd(), zip.path), exdir = shapefiles.path)

  if (delete.zip) {
    invisible(file.remove(file.path(getwd(), zip.path)))
    message(paste("Shapefiles downloaded into:", shapefiles.path))
  } else
    message(paste("Shapefiles downloaded into:", shapefiles.path))
}

#' make_us_contiguous
#'
#' \code{make_us_contiguous} removes states that are not in the contiguous United States, and drops levels from the internal data object.
#'
#' @param us_spdf SpatialPolygonDataFeame for the United States, requires @data with column state.fips
#'
#' @export
make_us_contiguous <- function(us_spdf) {
  if (is.na(match("state.fips", names(us_spdf@data)))) {
    stop("The SPDF provided does not have us_spdf@data$state.fips")
  }

  contiguous_fips_codes <-
    statesRcontiguous::fips_codes[statesRcontiguous::fips_codes$contiguous.united.states == TRUE, ]$fips.code
  contiguous_us_spdf <-
    us_spdf[us_spdf$state.fips %in% contiguous_fips_codes, ]
  # Drop unnecessary levels
  contiguous_us_spdf@data <- droplevels(contiguous_us_spdf@data)
  contiguous_us_spdf
}

#' make_us_spdf
#'
#' \code{make_us_spdf} returns shape files from census.gov
#'
#' @param resolution Resolution of the shapefiles, may only be "500k", "5m", or "20m". If \code{download.shapefiles=FALSE} these must already be downloaded. Default to "500k"
#' @param year Year for which the shapefiles should be requested, may only be 2013, 2014, or 2015. If \code{download.shapefiles=FALSE} these must already be downloaded. Default to 2015
#' @param shapefiles.path Path for shapefiles, if \code{download.shapefiles=FALSE} these must already be downloaded. Default to "shapefiles/"
#' @param download.shapefiles Download shapefiles in this function call, rather than separately calling \code{get_us_shape_files}. Default to TRUE
#' @param contiguous.only If TRUE the returned SPDF will only contain States in the contiguous United States. Default to TRUE.
#'
#' @export
make_us_spdf <- function(shapefiles.path = "shapefiles/",
                               year = "2015",
                               resolution = "500k",
                               contiguous.only = TRUE,
                               download.shapefiles = TRUE) {
  if (download.shapefiles) {
    get_us_shape_files(
      resolution = resolution,
      year = year,
      zip.path = "shapefiles.zip",
      shapefiles.path = shapefiles.path,
      delete.zip = TRUE
    )
  }

  us_shapefiles <-
    rgdal::readOGR(
      dsn = shapefiles.path,
      layer = paste0("cb_", year, "_us_state_", resolution),
      verbose = F
    )

  us_shapefiles$STATEFP <- as.character(us_shapefiles$STATEFP)
  us_shapefiles$STATEFP <- as.numeric(us_shapefiles$STATEFP)

  ## tidy format
  colnames(us_shapefiles@data) <-
    tolower(colnames(us_shapefiles@data))
  ## rename_ as otherwise no visible binding for global variable ‘stusps’
  us_shapefiles@data <- dplyr::rename_(
    us_shapefiles@data,
    "state.fips" = "statefp",
    "state.ns" = "statens",
    "geo.id" = "geoid",
    "a.land" = "aland",
    "a.water" = "awater",
    "aff.geo.id" = "affgeoid",
    "state.short.name" = "stusps"
  )

  if (contiguous.only) {
    make_us_contiguous(us_shapefiles)
  } else
    us_shapefiles

}
