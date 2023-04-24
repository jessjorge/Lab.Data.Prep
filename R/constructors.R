#' Helper functions that creates object of the med class
#'
#' This function takes the output of the 'var_def' function. It then makes sure
#' all of the data is in long form. After making sure the data is in the
#' right form, it then turns it into an object of class med.
#'
#' @param x The function returns a data frame.
#'
#' @returns The function returns an object of class med.
#' @export

new_med <- function(x) {

  # Putting our data into "long form" in order to prepare it for graphing
  # Essentially eliminating columns in favor of more rows
  x <- x |>
    tidyr::pivot_longer(
      cols = c(4:ncol(x)),
      names_to = "measure",
      values_to = "value"
    )

  # Labeling it as the correct class
  structure(x, class = "med")
}
