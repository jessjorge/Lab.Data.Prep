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
#' @param x A data frame that contains the values from our research.
#'
#' @param y This variable is ignored.
#'
#' @param measure This variable allows the user to specify what was being
#' measured in the trial.
#'
#' @param time_stamps Variable that will be plotted on the x-axis
#'
#' @param value Variable that will be plotted on the y-axis
#'
#' @param ... Placeholder for further arguments.
#'
#' @returns The function returns a visual of plotted data.
#'
#' @export
plot.med <- function(x, y, measure, time_stamps = time_stamps,
                     value = value, ...) {

  # Plots the data using the specified preferences
  x |>
    filter(measure == measure) |>
    ggplot() +
    geom_step(aes(x = {{ time_stamps }}, y = {{ value }}), size = .25) +
    labs(x = "Time", y = "Cummulative Responses") +
    theme_prism(base_size = 11, base_line_size = 0.30) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0))
}

# NOTES FROM DRBEAN
# --Add depends/imports (we need to depend for ggplot2). We have to depend for
# tidyverse because it isn't actually a package
