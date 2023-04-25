#' Helper functions that creates object of the med class
#'
#' This function takes a matrix and returns an object of class med.
#'
#' @param x A matrix.
#'
#' @returns The function returns an object of class med.
#' @export

med <- function(x) {
  structure(x, class = "med")
}

#' Selects a variable for plotting.
#'
#' This function takes a data frame from the var_def function and selects
#' a variable of interest. A matrix is then generated and converted into the
#' med class that can then be passed into a generic plotting function to
#' generate a cummulative record.
#'
#' @param x A data frame.
#' @param variable The variable of interest, will be the second column in the
#' matrix.
#' @returns The function returns an object of class med.
#' @export

select<- function(x, variable){
x <- x |>
  tidyr::pivot_longer(
    cols = c(4:ncol(x)),
    names_to = "measure",
    values_to = "value"
  )
x<- x |> dplyr::filter(measure == variable)
x<- x[,c(2,5)]
x<- as.matrix(x)
x<- med(x)
  }
