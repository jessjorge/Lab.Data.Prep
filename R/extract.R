#' @param prefix A character prefix for the filename specifying what type of
#' file you want to pull the data from. Ex: "DF"
#' @param subj_nums A vector of the precise numbers of the subjects you are
#' interested in. Ex: 21:30
#' @returns A list of dataframes, with each dataframe belonging to a different
#' @returns Returns a list of dataframes, with each dataframe belonging to a different
#' subject.
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
