## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(collapse = T, comment = "#>")
library(statesRcontiguous)

## ------------------------------------------------------------------------
get_us_shape_files()

## ------------------------------------------------------------------------
usa_contiguous <- make_us_shapefiles(year = "2015", resolution = "500k")
usa_all <- make_us_shapefiles(year = "2015", resolution = "500k", contiguous.only = FALSE)

## ------------------------------------------------------------------------
made_contiguous <- make_us_contiguous(usa_all)

## ------------------------------------------------------------------------
library(dplyr)
contiguous_fips_codes <- fips_codes %>%
  filter(contiguous.united.states == TRUE) %>%
  select(fips.code) %>%
  unlist(use.names = FALSE)

made_contiguous_manually <- usa_all[usa_all$state.fips %in% contiguous_fips_codes, ]

