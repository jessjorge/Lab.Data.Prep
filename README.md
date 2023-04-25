
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Lab.Data.Prep

<!-- badges: start -->
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
#> Loading required package: tidyverse
#> -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
#> v ggplot2 3.4.2     v purrr   0.3.4
#> v tibble  3.1.6     v dplyr   1.0.7
#> v tidyr   1.1.4     v stringr 1.4.0
#> v readr   2.1.1     v forcats 0.5.1
#> -- Conflicts ------------------------------------------ tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
#> 
#> Attaching package: 'Lab.Data.Prep'
#> The following object is masked from 'package:dplyr':
#> 
#>     select
#> The following object is masked from 'package:tidyr':
#> 
#>     extract

# Set working directory to a data folder
setwd("data")

# Extract files with a given subject number
subs<-extract("EB",c(11))
```

``` r
# Call mpc to create a med pc 
df<-mpc(subs[[1]],"d")
```

To make a dataframe, we require a dictionary of event-type/event-name
pairs. It is reccomended to first define the dictionary, then pass it
into the function.

``` r
# Event type = Event Name
vars <- c(
  "0.2" = "target",
  "0.51" = "alternative"
)

new_df<-var_def(df, vars, cumulative = TRUE)
```

All that’s left is to call a constructor function, **select**, then pass
it into the plotting function for an easy step function experience!

``` r
isolate<-select(new_df, "target  (cumulative)")
plot(isolate)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />
