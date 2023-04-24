#Constructors



new_med <- function(x){

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
