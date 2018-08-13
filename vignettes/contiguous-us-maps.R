## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
library(statesRcontiguous)

## ---- eval=TRUE, include=TRUE--------------------------------------------
library("statesRcontiguous")
library("dplyr")

shp_all_us_states %>%
  filter(contiguous.united.states == TRUE) %>%
  select(geometry) %>%
  plot()

## ------------------------------------------------------------------------
knitr::kable(statesrcontiguous_shapefile_details)

