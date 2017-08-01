
<!-- README.md is generated from README.Rmd. Please edit that file -->
statesRcontiguous?
==================

[![Travis-CI Build Status](https://travis-ci.org/martinjhnhadley/statesRcontiguous.svg?branch=master)](https://travis-ci.org/martinjhnhadley/statesRcontiguous)

statesRcontiguous provides a tiny (small enough for CRAN) package containing the following shapefiles for the United States of America:

-   States (last updated in 2016, and sourced from <http://www2.census.gov/geo/tiger/GENZ2016/shp/cb_2016_us_state_20m.zip>)
-   Congressional District Boundaries (last updated in 2016, and sourced from <http://www2.census.gov/geo/tiger/GENZ2016/shp/cb_2016_us_cd115_20m.zip>)
-   Counties (last updated in 2016, and sourced from <http://www2.census.gov/geo/tiger/GENZ2016/shp/cb_2016_us_county_20m.zip>)

All shapefiles include a column called `contiguous.united.states` which allows the dataset to be restricted to the contiguous US very simply:

``` r
library(statesRcontiguous)
library(leaflet)
shp_contiguous_states <- shp_all_us_states %>%
  filter(contiguous.united.states)
leaflet(shp_contiguous_states) %>%
  addTiles() %>%
  addPolygons()
```

Installation
============

This package is currently only available Github, and can be installed as follows:

``` r
devtools::install_github("martinjhnhadley/statesRcontiguous")
```

Should I use this package?
==========================

This package provides **only** the three shapefiles (states, congressional districts, counties) included in the package. It is intended for where you have a reproducible need for shapefiles for the (contiguous) US and don't want to have to download the files on the fly.

You might prefer to use the [tigris](https://github.com/walkerke/tigris) package which is available on CRAN, and provides tools to download any of the shapefiles from TIGER.

So why does this exist?
-----------------------

This package was designed for the University of Oxford's [Interactive Data Network](http://idn.it.ox.ac.uk) which exists to provide a visualisation service for academics at Oxford, using Shiny. The Shiny apps developed by researchers are not allowed to contain data files, instead data must be loaded from external DOI-issuing repositories like [Figshare](www.figshare.com).

By providing a small utility package with these shapefiles in, researchers can easily create choropleth of the US.

Data Source
===========

The actual shapefiles (borders) included in this package are from the US Census website, do note that they'd been augmented with additional data from other sources which are detailed in the following table

``` r
shapefile_details
#> # A tibble: 6 x 3
#>                             description  year
#>                                   <chr> <int>
#> 1 Details about congressional districts  2016
#> 2                Details about counties  2016
#> 3                  Details about states  2016
#> 4 Shapefile for congressional districts  2016
#> 5                Shapefile for counties  2016
#> 6                  Shapefile for states  2016
#> # ... with 1 more variables: url <chr>
```

License
=======

This package includes shapefiles from the US Census Bureau. All shapefiles provided by the US Census Bureau are TIGER/Line shapefiles and are offered to the public free of charge, see [TIGER/Line Shapefil Technical Documentation](http://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2016/TGRSHP2016_TechDoc.pdf) for details.

This package itself is made available under the MIT license.
