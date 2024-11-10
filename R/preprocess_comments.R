#' Preprocess Comment Data
#'
#' This function preprocesses the comment data by adding necessary columns and filtering.
#' @param data The comment data frame.
#' @return A preprocessed data frame.
#' @export
preprocess_comments <- function(data) {
  library(dplyr)
  data <- data %>%
    group_by(authorChannelId) %>%
    mutate(to_know_first_comment = row_number(publishedAt))
  return(data)
}
