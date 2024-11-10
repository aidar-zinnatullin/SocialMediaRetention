#' Extract Group Data Based on Initial Interaction within a Specified Time Frame
#'
#' This function identifies commenters whose first comment was on a video in a specified group (e.g., treated or control),
#' and who made their first comment within a specified number of days after the video release.
#' It then retrieves all comments made by these commenters.
#'
#' @param data The preprocessed data frame containing comment data.
#' @param group_videos A vector of `Doc_name` values representing the group of interest (treated or control).
#' @param days_after_release Number of days after video release within which the first comment must have been made (default is 7).
#' @return A data frame containing all comments from commenters whose first comment was on a video in `group_videos` within the specified time frame.
#' @examples
#' \dontrun{
#' treated_data <- get_group_data(preprocessed_data, treated_group, days_after_release = 7)
#' }
#' @export
get_group_data_time <- function(data, group_videos, days_after_release = 7) {
  # Ensure necessary packages are loaded
  library(dplyr)
  library(lubridate)  # For date arithmetic

  # Ensure date columns are in POSIXct format
  data <- data %>%
    mutate(
      publishedAt = as.POSIXct(publishedAt),
      contentDetails.videoPublishedAt = as.POSIXct(contentDetails.videoPublishedAt)
    )

  # Step 1: Identify the authors who meet the condition in their first comment
  authors_of_interest <- data %>%
    filter(to_know_first_comment == 1) %>%  # Only first comments
    filter(Doc_name %in% group_videos) %>%  # First comment is on a video in group_videos
    filter(publishedAt <= contentDetails.videoPublishedAt + days(days_after_release)) %>%  # First comment within specified days after release
    select(authorChannelId) %>%
    distinct()

  # Step 2: Filter all observations of these authors
  group_data <- data %>%
    filter(authorChannelId %in% authors_of_interest$authorChannelId)

  return(group_data)
}
