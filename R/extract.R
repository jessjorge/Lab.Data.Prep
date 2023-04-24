# HEAD
# Tyson
#' @title Extract Function
#'
#' @description
#' This function extracts the data from the multiple files generated from the
#' experiment and stores it into a list of dataframe objects, one for each
#' subject.
#'
#' @param prefix A character prefix for the filename specifying what type of
#' file you want to pull the data from. Ex: "DF"
#' @param subj_nums A vector of the precise numbers of the subjects you are
#' interested in. Ex: 21:30
#'
#' @returns A list of dataframes, with each dataframe belonging to a different
#' subject.
#'
#' @export
extract <- function(prefix, subj_nums) {
  suffix <- ".txt"

  ids <- c()
  for (s in 1:length(subject_numbers)) {
    ids[s] <- paste(toString(subject_numbers[s]), suffix, sep = "")
    ids[s] <- paste(prefix, toString(ids[s]), sep = "")
    ids[s] <- paste0(ids[s], "$")
  }
  sub.files <- list()

  for (s in 1:length(subject_numbers)) {
    filenames <- list.files(pattern = ids[[s]])
    sub.files[[s]] <- list()
    for (f in 1:length(filenames)) {
      sub.files[[s]][[f]] <- read.delim(filenames[f])
    }
    names(sub.files[[s]]) <- filenames
  }

  sub.files
}
#=======
# Tyson
#' @title Extract Function
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
#' @returns Returns a list of dataframes, with each dataframe belonging to a
#' different subject.
#' @export
extract <- function(prefix, subj_nums) {
  suffix <- ".txt"
  ids <- c()
  for (s in seq_along(subj_nums)){
    ids[s] <- paste(toString(subj_nums[s]), suffix, sep = "")
    ids[s] <- paste(prefix, toString(ids[s]), sep = "")
    ids[s] <- paste0(ids[s], "$")
  }
  sub_files <- list()
  for (s in seq_along(subj_nums)){
    filenames <- list.files(pattern = ids[[s]])
    sub_files[[s]] <- list()
    for (f in seq_along(filenames)) {
      sub_files[[s]][[f]] <- read.delim(filenames[f])
    }
    names(sub_files[[s]]) <- filenames
  }
  sub_files
}
#>>>>>>> 31202a0103e115510b251d82a523380ff743e76c
