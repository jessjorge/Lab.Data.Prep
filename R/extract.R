#' @title Extract Function
#' @name extract
#' @description
#' This function extracts the data from the multiple files generated from the
#' experiment and stores it into a list of dataframe objects, one for each
#' subject.
#' @note Before calling this function, make sure you're working directory is in
#' the file you want to extract the data from.
#' @param prefix A character prefix for the filename specifying what type of
#' file you want to pull the data from. Ex: "DF"
#' @param subj_nums A vector of the precise numbers of the subjects you are
#' interested in. Ex: 21:30
#' @returns Returns a list of dataframes, with each dataframe
#' belonging to a different subject.
#'
#' @examples
#' df <- extract("EB", 11)
#' df
#'
#' @export
extract <- function(prefix, subj_nums) {
  suffix <- ".txt"
  ids <- c()
  for (s in seq_along(subj_nums)) {
    ids[s] <- paste(toString(subj_nums[s]), suffix, sep = "")
    ids[s] <- paste(prefix, toString(ids[s]), sep = "")
    ids[s] <- paste0(ids[s], "$")
  }
  sub_files <- list()
  for (s in seq_along(subj_nums)) {
    filenames <- list.files(path = "./data/", pattern = ids[[s]])
    sub_files[[s]] <- list()
    for (f in seq_along(filenames)) {
      sub_files[[s]][[f]] <- read.delim(paste(
        "./data/", filenames[f], sep = ""))
    }
    names(sub_files[[s]]) <- filenames
  }
  sub_files
}
