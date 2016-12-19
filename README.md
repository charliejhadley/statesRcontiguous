# statesRcontiguous?

Need shapefiles for the United States of America for mapping? Do you *really* only need the contiguous US for a map example?

```r
library(statesRcontiguous)
library(leaflet)
leaflet(contiguous_us_spdf) %>%
  addTiles() %>%
  addPolygons()
```
![http://i.imgur.com/RUkUaU6.png](http://i.imgur.com/RUkUaU6.png)

# Installation

This package is not currently on CRAN, to install use:

```r
devtools::install_github("martinjhnhadley/statesRcontiguous")
```

# Usage

Programmatically download the shapefiles from census.gov with `get_us_shape_files` into the shapefiles.path directory:

```r
get_us_shape_files(
	resolution = "500k",
	year = "2015",
	zip.path = "shapefiles.zip",
            shapefiles.path = "shapefiles/",
            delete.zip = TRUE
)
```

Download AND import the shapefiles into a SpatialDataFrame containing only the contiguous states of the United States:

```r
make_us_spdf(
	shapefiles.path = "shapefiles/",
	year = "2015",
	resolution = "500k",
	contiguous.only = TRUE,
	download.shapefiles = TRUE
)
```

The options shown above are the default options for `make_us_spdf` and are provided within the package via `contiguous_us_spdf`

```r
library(statesRcontiguous)
library(leaflet)
leaflet(contiguous_us_spdf) %>%
  addTiles() %>%
  addPolygons()
```

# License

This package includes a copy of the following shapefiles from the US Census Bureau; http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_state_500k.zip. All rights reserved.

This package itself is made available under the MIT license.


