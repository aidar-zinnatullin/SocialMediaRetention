#' This function calculates the retention rates of commenters over specified time intervals.
#' The user can specify the column names for the video's publication time, the comment's publication time,
#' the video identifier, and the commenter identifier.
#'
#' @param data The data frame containing comment data.
#' @param intervals A vector of time intervals in days (default is seq(30, 450, 30)).
#' @param higher_level_pub_time A string specifying the column name for the video's publication time.
#' @param activity_time A string specifying the column name for the comment's publication time.
#' @param higher_level_id A string specifying the column name for the video identifier.
#' @param user_id A string specifying the column name for the commenter identifier.
#' @return A data frame with retention rates and percentages.
#' @examples
#' \dontrun{
#' retention_data <- calculate_retention(
#'     data = treated_data,
#'     intervals = seq(30, 450, 30),
#'     higher_level_pub_time = "contentDetails.videoPublishedAt",
#'     activity_time = "publishedAt",
#'     higher_level_id = "Doc_name",
#'     user_id = "authorChannelId"
#' )
#' }
#' @export
calculate_retention <- function(data, intervals = seq(30, 450, 30),
                                higher_level_pub_time, activity_time,
                                higher_level_id, user_id) {
  library(dplyr)
  library(lubridate)
  library(rlang)

  videoPublishedAt_sym <- sym(higher_level_pub_time)
  publishedAt_sym <- sym(activity_time)
  doc_name_sym <- sym(higher_level_id)
  author_id_sym <- sym(user_id)

  data <- data %>%
    mutate(
      !!videoPublishedAt_sym := as.POSIXct(!!videoPublishedAt_sym),
      !!publishedAt_sym := as.POSIXct(!!publishedAt_sym)
    )

  data <- data %>%
    mutate(
      first_interaction_video_publication_time = !!videoPublishedAt_sym,
      time_diff_days = as.numeric(difftime(!!publishedAt_sym, first_interaction_video_publication_time, units = "days"))
    ) %>%
    rowwise() %>%
    mutate(
      retention_period = findInterval(time_diff_days, intervals)
    )

  retention_data <- data %>%
    group_by(retention_period, !!doc_name_sym) %>%
    summarise(Commenters = n_distinct(!!author_id_sym), .groups = 'drop') %>%
    group_by(!!doc_name_sym) %>%
    mutate(percentage = Commenters / max(Commenters)) %>%
    ungroup()

  return(retention_data)
}

