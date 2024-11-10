#' Load YouTube Comment Data
#'
#' This function loads and combines multiple RData files containing YouTube comment data.
#' @param data_paths A vector of file paths to the RData files.
#' @return A combined data frame of all comments.
#' @export
load_comment_data <- function(data_paths) {
  data_list <- lapply(data_paths, function(path) {
    load(path)
    get(ls()[ls() != "path"])
  })
  combined_data <- do.call(rbind, data_list)
  rm(list = ls()[!ls() %in% c("combined_data")])
  gc()
  return(combined_data)
}
