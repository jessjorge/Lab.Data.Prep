# df := a dataframe with 4 columns (session, time_stamps, event_tags, id)
# event_tags := essentially a dictionary of key_value pairs
# which map event_tag values to a variable name
# cumulative := should we also add a cumulative variable to this thing

ev_tags <- c(
  "0.111" = "beginning",
  "0.2" = "rat given mate",
  "0.25" = "rat given steroids",
  "0.4" = "water withdrawn, doom impending",
  "0.41" = "rat got prodded",
  "0.42" = "rat fights snake, wins",
  "0.6" = "rat got poked",
  "0.61" = "rat fights snake, loses",
  "0.65" = "rat played dress-up",
  "0.999" = "gave rat some LSD"
)

df <- mpc(sub.files[[1]], "d")

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

my_x <- var_def(df, ev_tags)
