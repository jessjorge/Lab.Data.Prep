# Jessica

# Do we need to call this library outside of the function?
library(ggprism)
library(ggplot2)
library(tidyverse)
library(tidyr)


#' Generic Plot Function
#'
#' ADD THE DESCRIPTION HERE
#'
#' @param timestamp A measure of time that will be converted to hours
#'
#' @param x A data frame that contains the values from our research.
#'
#' @param y This variable is ignored.
#'
#' @param ... Placeholder for further arguments.
#'
#' @examples
#' @returns The function returns a visual of plotted data
#'
#' @export
generic_plot <- function(x, y, measure, time_stamp, value, ...) {

  # Putting our data into "long form" in order to prepare it for graphing
  # Essentially eliminating columns in favor of more rows
  x <- x |>
    tidyverse::pivot_longer(
      cols = c(3:6),
      names_to = "measure",
      values_to = "value"
    )
  # WRITE SOMETHING
  x |>
    filter(measure == measure) |>
    ggplot() +
    geom_step(aes(x = {{ time_stamp }}, y = {{ value }}), size = .25) +
    labs(x = "Time", y = "Cummulative Responses") +
    theme_prism(base_size = 11, base_line_size = 0.30) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0))
}

#NOTES FROM DRBEAN
# *Test that the function works before doing the following steps to make it a generic
#
# -Need to make a class function
# -call plot.class()
#
# --Add depends/imports (we need to depend for ggplot2). We have to depend for
# tidyverse because it isn't actually a package
