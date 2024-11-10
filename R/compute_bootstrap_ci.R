#' Compute Bootstrap Confidence Intervals
#'
#' This function computes bootstrap confidence intervals for retention rates.
#' @param data The retention data frame.
#' @param n_bootstrap Number of bootstrap samples.
#' @return A data frame with mean and confidence intervals.
#' @export
compute_bootstrap_ci <- function(data, n_bootstrap = 1000, confidence_intervals = 0.95) {
  library(Hmisc)
  set.seed(123)
  ci_data <- data %>%
    group_by(retention_period) %>%
    do(data.frame(rbind(smean.cl.boot(.$percentage, conf.int = confidence_intervals, B =n_bootstrap, na.rm =TRUE, reps=TRUE))))
  return(ci_data)
}
