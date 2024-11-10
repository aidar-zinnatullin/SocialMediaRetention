#' Visualize Retention Rates
#'
#' This function generates a plot of retention rates with confidence intervals.
#' @param treated_data The data frame for the treated group.
#' @param control_data The data frame for the control group.
#' @return A ggplot object.
#' @export
visualize_retention <- function(treated_data, control_data) {
  library(ggplot2)
  ggplot(treated_data, aes(x = retention_period, y = Mean)) +
    geom_line(color = "red") +
    geom_ribbon(aes(ymin = Lower, ymax = Upper), alpha = 0.2, fill = "red") +
    geom_line(data = control_data, aes(x = retention_period, y = Mean), color = "blue") +
    geom_ribbon(data = control_data, aes(ymin = Lower, ymax = Upper), alpha = 0.2, fill = "blue") +
    labs(
      x = "Retention Period (Months)",
      y = "Proportion of Commenters",
      title = "Retention Rates Over Time",
      fill = "Group"
    ) +
    scale_x_continuous(breaks = seq_along(unique(treated_data$retention_period)), labels = seq_along(unique(treated_data$retention_period))) +
    theme_minimal()
}
