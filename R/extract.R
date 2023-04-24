#' @param prefix A character prefix for the filename specifying what type of
#' file you want to pull the data from. Ex: "DF"
#' @param subject_numbers A vector of the precise numbers of the subjects you are
#' interested in. Ex: 21:30
#'
#' @returns A list of dataframes, with each dataframe belonging to a different
#' subject.
#'
#' @export
extract <- function(prefix, subject_numbers) {
  suffix <- ".txt"

  ids <- c()
  for (s in seq_along(subject_numbers)) {
    ids[s] <- paste(toString(subject_numbers[s]), suffix, sep = "")
    ids[s] <- paste(prefix, toString(ids[s]), sep = "")
    ids[s] <- paste0(ids[s], "$")
  }
  sub.files <- list()

  for (s in seq_along(subject_numbers)) {
    filenames <- list.files(pattern = ids[[s]])
    sub.files[[s]] <- list()
    for (f in seq_along(filenames)) {
      sub.files[[s]][[f]] <- read.delim(filenames[f])
    }
    names(sub.files[[s]]) <- filenames
  }

  sub.files
}
