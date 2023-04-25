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
  plot(x[, "time_stamps"], x[, "value"],
    type = "s", xlab = "Time Stamp", ylab = "Response",
    main = "Cumulative Record"
  )
}
