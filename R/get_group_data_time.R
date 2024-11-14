#' This function identifies commenters whose first comment was on a video in a specified group (e.g., treated or control),
#' and who made their first comment within a specified number of days after the video release.
#' It then retrieves all comments made by these commenters.
#'
#' @param data The data frame containing comment data.
#' @param group_videos A vector of video identifiers (e.g., `Doc_name`) representing the group of interest.
#' @param days_after_release Number of days after video release within which the first comment must have been made (default is 7).
#' @param activity_time A string specifying the column name for the comment's publication time.
#' @param higher_level_pub_time A string specifying the column name for the video's publication time.
#' @param higher_level_id A string specifying the column name for the video identifier.
#' @param user_id A string specifying the column name for the commenter identifier.
#' @return A data frame containing all comments from commenters whose first comment was on a video in `group_videos` within the specified time frame.
#' @examples
#' \dontrun{
#' treated_data <- get_group_data_time(
#'     data = preprocessed_data,
#'     group_videos = treated_group,
#'     days_after_release = 7,
#'     activity_time = "publishedAt",
#'     higher_level_pub_time = "contentDetails.videoPublishedAt",
#'     higher_level_id = "Doc_name",
#'     user_id = "authorChannelId"
#' )
#' }
#' @export
get_group_data_time <- function(data, group_videos, days_after_release = 7,
                                activity_time, higher_level_pub_time,
                                higher_level_id, user_id) {

  publishedAt_sym <- rlang::sym(activity_time)
  videoPublishedAt_sym <- rlang::sym(higher_level_pub_time)
  doc_name_sym <- rlang::sym(higher_level_id)
  author_id_sym <- rlang::sym(user_id)

  data <- data |>
    dplyr::mutate(
      !!publishedAt_sym := as.POSIXct(!!publishedAt_sym),
      !!videoPublishedAt_sym := as.POSIXct(!!videoPublishedAt_sym),
      date_after_release = (!!videoPublishedAt_sym) + lubridate::days(days_after_release)
    )

  authors_of_interest <- data |>
    dplyr::filter(to_know_first_comment == 1) |>
    dplyr::filter(!!doc_name_sym %in% group_videos) |>
    dplyr::filter(!!publishedAt_sym <= date_after_release) |>
    dplyr::select(!!author_id_sym) |>
    dplyr::distinct()

  group_data <- data |>
    dplyr::filter(!!author_id_sym %in% authors_of_interest[[user_id]])

  return(group_data)
}
