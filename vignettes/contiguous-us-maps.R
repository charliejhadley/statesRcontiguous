## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
library(statesRcontiguous)

## ---- eval=TRUE, include=TRUE--------------------------------------------
library("statesRcontiguous")
library("dplyr")
library("leaflet")
shp_contiguous_us_congressional_districts <- shp_all_us_congressional_districts %>%
  filter(contiguous.united.states)
shp_contiguous_us_congressional_districts %>%
  leaflet() %>%
  addTiles() %>%
  addPolygons(weight = 1)

## ------------------------------------------------------------------------
knitr::kable(statesrcontiguous_shapefile_details)

