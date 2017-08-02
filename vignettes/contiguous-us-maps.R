## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
library(statesRcontiguous)

## ------------------------------------------------------------------------
library("statesRcontiguous")
library("tidyverse")
library("leaflet")
shp_contiguous_us_congressional_districts <- shp_all_us_congressional_districts %>%
  filter(contiguous.united.states)
shp_contiguous_us_congressional_districts %>%
  leaflet() %>%
  addTiles() %>%
  addPolygons(weight = 1)

## ------------------------------------------------------------------------
knitr::kable(shapefile_details)

