
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Lab.Data.Prep

<!-- badges: start -->

[![R-CMD-check](https://github.com/jessjorge/Lab.Data.Prep/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jessjorge/Lab.Data.Prep/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The Lab Data Prep package is designed to streamline some common
laboratory data prep tasks. Rat study data is often delivered in a
format that is difficult to understand and work with; however, many of
the data cleaning tasks are routine. This package consolidates these
routine tasks into a few simple functions that can be called with ease,
and provides a plotting utility function to use after data conversion.
What formerly took a few hundred lines of code is now just a few
function calls away.

## Installation

You can install the development version of Lab.Data.Prep from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jessjorge/Lab.Data.Prep")
```

## Example

Med PC is the program used for data collection in this laboratory
setting. The **mpc** function produces an mpc dataframe.

``` r
library(Lab.Data.Prep)

# Extract files with a given subject number
subs <- extract("EB", c(11))
```

``` r
# Call mpc to create a med pc
df <- mpc(subs[[1]], "d")
```

To make a dataframe, we require a dictionary of event-type/event-name
pairs. It is reccomended to first define the dictionary, then pass it
into the function.

``` r
# Event type = Event Name
vars <- c(
  "0.2" = "Gave Rat Some LSD",
  "0.51" = "Rat Turned Into a Butterfly",
  "0.65" = "Rat Fights Snake, Loses",
  "0.66" = "Rat Fights Snake, Wins",
  "0.75" = "Rat Literacy Tests",
  "0.85" = "Water Spiked with Strawberry Wine"
)

new_df <- var_def(df, vars, cumulative = TRUE)
```

All that’s left is to call a constructor function, **select**, then pass
it into the plotting function for an easy step function experience!

``` r
isolate <- select(new_df, "target  (cumulative)")
plot(isolate)
```

![The output plot](man/figures/README-unnamed-chunk-4-1.png)
