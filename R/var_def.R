#' Title
#'
#' Function description
#'
#' @param df Describe parameter here
#'
#' @param event_tags Describe parameter here
#'
#' @param cumulative Describe parameter here
#'
#' @returns Describe what it returns here
#'
#' @export
var_def <- function(df, event_tags, cumulative = TRUE) {

  # Keep a subset of the columns which does not include the event tag col
  x <- df[,c(1,2,4)]
  df$event_tags <- as.numeric(as.character(df$event_tags))

  # First, loop through all the event tags
  for (event_tag in names(event_tags)){

    # For each event tag, loop through all the rows in the dataframe
    for (i in seq_along(df[,1])){

      # If the row's event tag corresponds to the current event tag...
      if (df$event_tags[i] == event_tag){

        # Assign length (probably a 1) to the column corresponding to
        # the event tag and each unique timestamp. Note that this code will
        # create a new column in x for each event tag in its first iteration.
        x[i, event_tags[event_tag]] <- length(
          df$event_tags[df$event_tags == event_tag &
                          df$time_stamps == df$time_stamps[i]])
      } else{
        x[i, event_tags[event_tag]] <- 0
      }
    }
  }
  return(x)
}
