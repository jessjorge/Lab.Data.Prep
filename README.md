
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
setting. The **mpc** function produces an mpc dataframe. **write some
stuff about how extract works**

``` r
library(Lab.Data.Prep)

# Extract files with a given subject number
subs <- extract("EB",11,paste(system.file("extdata", package = "Lab.Data.Prep"),"/", sep = ""))
```

We call mpc on the subs **write some stuff about mpc**

``` r
# Call mpc to create a med pc
df <- mpc(subs[[1]], "d")
```

The new dataframe has 9 unique event tags. Each of these numbers
corresponds to a unique event type, which will be passed in by a
practitioner in the form of an R dictionary.

``` r
unique(df$event_tags)
#> [1] 0.111 0.2   0.5   0.51  0.71  0.52  0.7   0.21  0.999
#> Levels: 0.111 0.2 0.21 0.5 0.51 0.52 0.7 0.71 0.999
```

A dictionary in R looks a lot like a vector, but each element consists
of a key and a value, separated by an equals sign. The user should
define this dictionary as follows and pass it into the var_def function.
var_def will take the dictionary and create a new dummy variable (1’s &
0’s) column named after each value.

``` r
# Event type = Event Name
vars <- c(
  "0.111" = "Rat Earns LSD",
  "0.2" = "Rat Turned Into a Butterfly",
  "0.5" = "Rat Fights Snake, Loses",
  "0.51" = "Rat Fights Snake, Wins",
  "0.71" = "Rat Literacy Tests",
  "0.52" = "Water Spiked with Strawberry Wine"
)

new_df <- var_def(df, vars, cumulative = TRUE)
```

Now we take a look at the new dataframe. var_def has created binary
variables for each element of the vars dictionary. At each time_stamp,
if the event of interest occurred there is a 1 in the corresponding
column.

``` r
head(new_df)
#>   session time_stamps   id Rat Earns LSD Rat Turned Into a Butterfly
#> 1       1  0.00000000 EB11             1                           0
#> 2       1  0.02100000 EB11             0                           1
#> 3       1  0.02116667 EB11             0                           0
#> 4       1  0.02116667 EB11             0                           0
#> 5       1  0.02950000 EB11             0                           0
#> 6       1  0.03783333 EB11             0                           0
#>   Rat Fights Snake, Loses Rat Fights Snake, Wins Rat Literacy Tests
#> 1                       0                      0                  0
#> 2                       0                      0                  0
#> 3                       1                      0                  0
#> 4                       0                      1                  0
#> 5                       0                      1                  0
#> 6                       0                      1                  0
#>   Water Spiked with Strawberry Wine Rat Earns LSD  (cumulative)
#> 1                                 0                           1
#> 2                                 0                           1
#> 3                                 0                           1
#> 4                                 0                           1
#> 5                                 0                           1
#> 6                                 0                           1
#>   Rat Turned Into a Butterfly  (cumulative)
#> 1                                         0
#> 2                                         1
#> 3                                         1
#> 4                                         1
#> 5                                         1
#> 6                                         1
#>   Rat Fights Snake, Loses  (cumulative) Rat Fights Snake, Wins  (cumulative)
#> 1                                     0                                    0
#> 2                                     0                                    0
#> 3                                     1                                    0
#> 4                                     1                                    1
#> 5                                     1                                    2
#> 6                                     1                                    3
#>   Rat Literacy Tests  (cumulative)
#> 1                                0
#> 2                                0
#> 3                                0
#> 4                                0
#> 5                                0
#> 6                                0
#>   Water Spiked with Strawberry Wine  (cumulative)
#> 1                                               0
#> 2                                               0
#> 3                                               0
#> 4                                               0
#> 5                                               0
#> 6                                               0
```

Now we run select to just grab the columns that we want for plotting.
Because we love giving rats LSD, we are grabbing the “Gave Rat Some LSD
(Cumulative)” variable. Note that the variable name must be typed
exactly, and there are **two spaces** between the *variable name* and
the *(cumulative)* component.

``` r
isolate <- select(new_df, "Gave Rat Some LSD  (cumulative)")
```

Now the data has been transformed and is suitable for plotting.

``` r
head(isolate)
#>      time_stamps value
```

All that’s left is to plot!

![The output plot](man/figures/README-unnamed-chunk-4-1.png)
