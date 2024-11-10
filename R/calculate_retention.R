#' Calculate Retention Rates
#'
#' This function calculates the retention rates of commenters over specified time intervals.
#' @param data The preprocessed comment data.
#' @param intervals A vector of time intervals in days.
#' @return A data frame with retention rates.
#' @export
calculate_retention <- function(data, intervals = seq(30, 450, 30)) {
  library(dplyr)
  data <- data %>%
    mutate(first_interaction_video_publication_time = contentDetails.videoPublishedAt) %>%
    rowwise() %>%
    mutate(
      retention_period = findInterval(
        as.numeric(difftime(publishedAt, first_interaction_video_publication_time, units = "days")),
        intervals
      )
    )
  retention_data <- data %>%
    group_by(retention_period, Doc_name) %>%
    summarise(Commenters = n_distinct(authorChannelId)) %>%
    group_by(Doc_name) %>%
    mutate(percentage=Commenters/max(Commenters))
  return(retention_data)
}

