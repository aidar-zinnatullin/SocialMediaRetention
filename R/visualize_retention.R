#' Visualize Retention Rates
#'
#' This function generates a plot of retention rates with confidence intervals.
#' @param treated_data The data frame for the treated group.
#' @param control_data The data frame for the control group.
#' @return A ggplot object.
#' @export
visualize_retention <- function(treated_data, control_data) {
  treated_data$Group <- "Treated"
  control_data$Group <- "Control"
  combined_data <- rbind(treated_data, control_data)
  ggplot2::ggplot(combined_data, ggplot2::aes(x = retention_period, y = Mean, color = Group, fill = Group)) +
    ggplot2::geom_line(data = treated_data, ggplot2::aes(color = "Treated"), size = 1) +
    ggplot2::geom_ribbon(
      data = treated_data,
      ggplot2::aes(ymin = Lower, ymax = Upper, fill = "Treated"),
      alpha = 0.1
    ) +
    ggplot2::geom_line(data = control_data, ggplot2::aes(color = "Control"), size = 1) +
    ggplot2::geom_ribbon(
      data = control_data,
      ggplot2::aes(ymin = Lower, ymax = Upper, fill = "Control"),
      alpha = 0.1
    ) +
    ggplot2::labs(
      x = "Retention Period (Months)",
      y = "Proportion of Users",
      title = "Retention Rates Over Time",
      color = "Group",
      fill = "Group"
    ) +
    ggplot2::scale_color_manual(values = c("Control" = "orange", "Treated" = "darkviolet")) +
    ggplot2::scale_fill_manual(values = c("Control" = "orange", "Treated" = "darkviolet")) +
    ggplot2::scale_x_continuous(
      breaks = seq_along(unique(treated_data$retention_period)),
      labels = seq_along(unique(treated_data$retention_period))
    ) +
    ggplot2::theme_light()
}

