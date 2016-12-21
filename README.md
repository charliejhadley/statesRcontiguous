# statesRcontiguous?

[![Travis-CI Build Status](https://travis-ci.org/martinjhnhadley/statesRcontiguous.svg?branch=master)](https://travis-ci.org/martinjhnhadley/statesRcontiguous)

Need shapefiles for the United States of America for mapping? Do you ***really*** only want to see the contiguous United States of America[<sup>1</sup>](#Maps-of-places-that-are not-the-US)?

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

# Maps of places that are not the US

<sup>1</sup> If you don't have a genuine need to show America, for instance you're writing a tutorial on mapping in R, ask: why do you want to show America? There *are* collections of shapefiles for other countries/supra-national entities, some places to look include: [http://gadm.org/](http://gadm.org/), [datapages.com](http://datapages.com/gis-map-publishing-program/gis-open-files/global-framework/global-heat-flow-database/shapefiles-list), [thematicmapping.com](http://thematicmapping.org/downloads/world_borders.php) and there's good information about shapefiles on [openstreetmap.org](http://wiki.openstreetmap.org/wiki/Shapefiles)

This library serves a useful<sup>2</sup> purpose, obtaining an explicit SpatialPolgygonsDataFrame, and I aim to build a few other tongue in cheek collections of shapefiles as R libraries:

- islesRkingdom: Shapefiles for Republic of Ireland, Northern Ireland, Scotland, England, Wales, Cornwall, Channel Islands, Orkney Islands and every mix there of. Great Britian, British Isles, United Kingdom, Wangland and more.

<sup>2</sup> Hopefully, also see https://twitter.com/martinjhnhadley/status/811148917689745408

# License

This package includes a copy of the following shapefiles from the US Census Bureau; http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_state_500k.zip. All shapefiles provided by the US Census Bureau are TIGER/Line shapefiles and are offered to the public free of charge, see [TIGER/Line Shapefil Technical Documentation](http://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2016/TGRSHP2016_TechDoc.pdf) for details.

This package itself is made available under the MIT license.


