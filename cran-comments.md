## Resubmission
This is a resubmission, apologies for forgetting resubmission notes previously. In this version I have:

* Removed references to TIGER from the DESCRIPTION as it's a tautological description of the US Census' shapefile products. Instead, users of the package are told the package contains shapefiles that are generated from the combination of multiple shapefiles products from the US Census.

* Added single quotes around the package variable 'shapefile_details' in the DESCRIPTION

## Release summary

This minor release was precipitated by an email on behalf of tidyverse package maintainer noting that the tidyverse should be removed from Suggests. The opportunity was also taken to update the package to enable tibble printing for the exported objects, and the internal package infrastructure for keeping track of data sources has been overhauled - note that this has led to the deprecation of `shapefile_details`.

## Test environments

* local OS X install, R 3.4.4
* Ubuntu 14.04.5 LTS (on travis-ci), R 3.4.1, R 3.3.3, R-devel.
* win-builder (devel)

### R-devel Failure

Package failed to build on R-devel due to the following error:

Error: package ‘devtools’ was installed by an R version with different internals; it needs to be reinstalled for use with this R version

## R CMD check results

0 errors | 0 warnings | 0 notes
