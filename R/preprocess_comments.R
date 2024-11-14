#' This function preprocesses the comment data by adding a column that indicates
#' the order of comments for each user based on a specified time variable.
#'
#' @param data The data frame containing comment data.
#' @param user_id A string specifying the column name to group by (e.g., user ID).
#' @param activity_time A string specifying the time variable to order the comments (e.g., time of activity).
#' @return A data frame with an additional column `to_know_first_comment` indicating the order of comments.
#' @examples
#' \dontrun{
#' preprocessed_data <- preprocess_comments(data, user_id = "authorChannelId", activity_time = "publishedAt")
#' }
#' @export
preprocess_comments <- function(data, user_id, activity_time) {
  group_by_var_sym <- rlang::sym(user_id)
  publishedAt_var_sym <- rlang::sym(activity_time)

  data <- data |>
    dplyr::group_by(!!group_by_var_sym) |>
    dplyr::mutate(to_know_first_comment = dplyr::row_number(!!publishedAt_var_sym)) |>
    dplyr::ungroup()
  return(data)
}
