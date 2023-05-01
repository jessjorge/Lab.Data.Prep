#' MPC to R Data Frame
#'
#' This function takes a sequential list of mpc files for an individual subject,
#' extracts a single, user-defined array,
#' and creates a single data frame containing
#' time stamps and event tags. Specifically, this function is designed to handle
#' arrays structured with a timestamp with a decimal that identifies event type.
#'
#' @param x A list of mpc files for a single subject. These mpc files must first
#' be converted into .txt file types before being imported to R.
#' @param array A character string identifying the array to be extracted. This
#' character string should contain a single letter.
#' @param timescale A character string identifying the timescale that timestamps
#' should be converted to. Available timescales are: "hour", "min", "sec",
#' and "cent".
#' @param cummulative A logical indicating whether timestamps should be
#' merged cumulatively across sessions. If FALSE, time will be treated
#' independently for each session.
#'
#' @returns A data frame containing subject id, session id, timestamps, and
#' associated event tags.
#'
#' @examples
#' \dontrun{ x <- extract("EB", 11)
#' df <- mpc(x[[1]], "d")
#' df
#' }
#' @export
mpc <- function(x, array, timescale = "min", cummulative = TRUE) {
  # parsing text array into a data frame
  if (stringr::str_detect(array, "[:upper:]") == FALSE) {
    array <- toupper(array)
  }

  startarray <- paste(array, ":", sep = "")
  endarray <- paste(LETTERS[which(LETTERS == array) + 1L], ":", sep = "")
  new_vec <- vector("list", length(x))
  for (c in seq_along(x)) {
    text_data <- data.frame()
    text_data <- rbind(text_data, x[[c]])

    suppressWarnings(split_data <- tidyr::separate(text_data,
      col = 1,
      into = c(
        "Col1", "Col2", "Col3", "Col4", "Col5",
        "Col6", "Col7"
      ),
      sep = " +"
    ))
    id <- split_data[3, 2]
    start_row <- which(split_data$Col1 == startarray)
    end_row <- which(split_data$Col1 == endarray)
    filtered_data <- dplyr::filter(
      split_data,
      dplyr::row_number() %in% (start_row + 1):(end_row - 1)
    )
    long_data <- data.frame()
    row_index <- 1
    for (i in seq_len(nrow(filtered_data))) {
      for (j in 3:7) {
        long_data[row_index, 1] <- filtered_data[i, j]
        row_index <- row_index + 1
      }
    }
    long_data <- na.omit(long_data)
    long_data <- transform(long_data, V1 = as.numeric(V1))

    names(long_data)[1] <- "time_plus_event"

    times_events <- data.frame(
      time_stamps = numeric(),
      event_tags = numeric()
    )

    for (i in seq_len(nrow(long_data))) {
      times_events[i, 1] <- floor(long_data[i, 1])
      times_events[i, 2] <- long_data[i, 1] - times_events[i, 1]
    }

    df <- round(times_events$event_tags, digits = 3)
    df <- cbind(times_events, df)
    df <- df[, c(1, 3)]
    colnames(df) <- c("time_stamps", "event_tags")
    df$event_tags <- as.factor(df$event_tags)
    new_vec[[c]] <- df
  }

  # merge data frames from list into one data frame
  merged_df <- do.call(rbind, Map(cbind, session = seq_along(new_vec), new_vec))
  merged_df$id <- id

  # convert time
  # if (timescale == "hour") {
  #   merged_df$time_stamps <- merged_df$time_stamps / 360000
  # } else if (timescale == "min") {
  #   merged_df$time_stamps <- merged_df$time_stamps / 6000
  # } else if (timescale == "sec") {
  #   merged_df$time_stamps <- merged_df$time_stamps / 100
  # } else if (timescale == "cent") {
  #   merged_df$time_stamps <- merged_df$time_stamps
  # } else {
  #   warning(paste(
  #     "Timescale argument", paste("'", timescale, "'", sep = ""),
  #     "not recognized.
  #                 Available arguments are: 'hour','min','sec','cent'.
  #                 Centiseconds have been retained."
  #   ))
  # }

  switch(timescale,
         "hour" = merged_df$time_stamps <- merged_df$time_stamps / 360000,
         "min" = merged_df$time_stamps <- merged_df$time_stamps / 6000,
         "sec" = merged_df$time_stamps <- merged_df$time_stamps / 100,
         "cent" = merged_df$time_stamps <- merged_df$time_stamps,
         warning(paste(
           "Timescale argument", paste("'", timescale, "'", sep = ""),
           "not recognized.
                  Available arguments are: 'hour','min','sec','cent'.
                  Centiseconds have been retained."
         )))

  # make time cumulative
  j <- 2
  if (cummulative == TRUE) {
    for (j in 2:length(levels(as.factor(merged_df$session)))) {
      merged_df$time_stamps[merged_df$session == j] <-
        merged_df$time_stamps[merged_df$session == j] +
        (max(merged_df$time_stamps[merged_df$session == j - 1]))
    }
  }

  return(merged_df)
}
