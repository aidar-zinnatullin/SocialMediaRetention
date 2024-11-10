#' Extract Group Data Based on Initial Interaction
#'
#' This function identifies commenters whose first comment was on a video in a specified group (e.g., treated or control),
#' and then retrieves all comments made by these commenters.
#'
#' @param data The preprocessed data frame containing comment data.
#' @param group_videos A vector of `Doc_name` values representing the group of interest (treated or control).
#' @return A data frame containing all comments from commenters whose first comment was on a video in `group_videos`.
#' @examples
#' \dontrun{
#' treated_data <- get_group_data(preprocessed_data, treated_group)
#' }
#' @export
get_group_data <- function(data, group_videos) {
  # Ensure necessary packages are loaded
  library(dplyr)

  # Step 1: Identify the authors who meet the condition in their first comment
  authors_of_interest <- data %>%
    filter(Doc_name %in% group_videos & to_know_first_comment == 1) %>%
    select(authorChannelId) %>%
    distinct()

  # Step 2: Filter all observations of these authors
  group_data <- data %>%
    filter(authorChannelId %in% authors_of_interest$authorChannelId)

  return(group_data)
}
