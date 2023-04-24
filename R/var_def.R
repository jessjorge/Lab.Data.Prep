#' Define Dummy Variables
#' @name var_def
#' @param df Dataframe that is being fed into the function. It is essential
#' that this dataframe be output by the mpc function, also defined in this
#' package. You may pass in a different dataframe but the format must be
#' identical to that of an mpc output.
#' @param event_tags A dictionary consisting of key value pairs. The
#' keys should correspond to all unique "event code" entries and the values
#' should be event names. These names will become the columns of the output
#' dataframe.
#' @param cumulative If set to TRUE, the function will also output columns
#' that keep track of the total number of times a particular event took place.
#' @returns This function returns a dataframe x, whose first three columns
#' are identical to the input dataframe, df, but with additional columns
#' including dummy variables for unique events and corresponding cumulative
#' columns.
#' @example
#' #-------------------------------------
#' ev_tags <- c(
#' "0.111" = "beginning",
#' "0.2" = "rat given mate",
#' "0.25" = "rat given steroids",
#' "0.4" = "water withdrawn, doom impending",
#' "0.41" = "rat got prodded",
#' "0.42" = "rat fights snake, wins",
#' "0.6" = "rat got poked",
#' "0.61" = "rat fights snake, loses",
#' "0.65" = "rat played dress-up",
#' "0.999" = "gave rat some LSD"
#' )
#'
#' df <- mpc(sub.files[[1]], "d")
#'
#' my_x <- var_def(df, ev_tags)
#'
#' #-------------------------------------
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

  # Now, if cumulative is true we want a cumulative column as well
  if (cumulative == TRUE){
    for(col in colnames(x)[4:length(x)]){
      cumname <- paste(col, " (cumulative)")
      x[cumname] <- cumsum(x[col] == 1)
    }
  }

  return(x)
}
