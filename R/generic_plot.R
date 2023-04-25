# Jessica

# Do we need to call this library outside of the function?
library(ggprism)
library(ggplot2)
library(tidyverse)
library(tidyr)


#' Generic Plot Function
#'
#' This function takes in our our newly cleaned data. It then plots the data
#' allowing researchers to see a visual representation of their data.
#'
#' @param x A matrix that contains the values from our research.This is an
#' object of class med.
#'
#' @param y This variable is ignored.
#'
#' @param ... Placeholder for further arguments.
#'
#' @returns The function returns a visual of plotted data.
#'
#' @export
plot.med <- function(x, y, ...) {

  # Plots the data using the specified preferences
  x |>
    ggplot() +
    geom_step(aes(x = time_stamps, y = value), size = .25) +
    labs(x = "Time", y = "Cummulative Responses") +
    theme_prism(base_size = 11, base_line_size = 0.30) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0))
}

# NOTES FROM DRBEAN
# --Add depends/imports (we need to depend for ggplot2). We have to depend for
# tidyverse because it isn't actually a package
