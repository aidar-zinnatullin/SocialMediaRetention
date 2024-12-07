% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute_bootstrap_ci.R
\name{compute_bootstrap_ci}
\alias{compute_bootstrap_ci}
\title{Compute Bootstrap Confidence Intervals}
\usage{
compute_bootstrap_ci(data, n_bootstrap = 1000, confidence_intervals = 0.95)
}
\arguments{
\item{data}{The retention data frame.}

\item{n_bootstrap}{Number of bootstrap samples.}
}
\value{
A data frame with mean and confidence intervals.
}
\description{
This function computes bootstrap confidence intervals for retention rates.
}
