
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SocialMediaRetention

<!-- badges: start -->
<!-- badges: end -->

SocialMediaRetention aims to compute the retention rates for two cohorts
of users (for instance, YouTube commenters who interact with videos
released at different periods). Here is an example:
<https://firstmonday.org/ojs/index.php/fm/article/view/12882>

## Installation

You can install the development version of SocialMediaRetention like so:

``` r
devtools::install_github("aidar-zinnatullin/SocialMediaRetention")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(SocialMediaRetention)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
load("data/retention_control.Rdata")
load("data/retention_treat.Rdata")
treated_ci_data <- compute_bootstrap_ci(retention_data_treated, n_bootstrap = 100, confidence_intervals = 0.95)
head(treated_ci_data, n = 5)
#> # A tibble: 5 × 4
#>   retention_period    Mean   Lower  Upper
#>              <int>   <dbl>   <dbl>  <dbl>
#> 1                0 1       1       1     
#> 2                1 0.00986 0.00371 0.0161
#> 3                2 0.187   0.0169  0.511 
#> 4                3 0.0768  0.0451  0.108 
#> 5                4 0.0497  0.0160  0.0937
```

``` r
control_ci_data <- compute_bootstrap_ci(retention_data_control, n_bootstrap = 100, confidence_intervals = 0.95)
head(control_ci_data, n = 5)
#> # A tibble: 5 × 4
#>   retention_period    Mean   Lower  Upper
#>              <int>   <dbl>   <dbl>  <dbl>
#> 1                0 0.999   0.997   1     
#> 2                1 0.00864 0.00374 0.0148
#> 3                2 0.0106  0.00532 0.0174
#> 4                3 0.144   0.0174  0.363 
#> 5                4 0.00766 0.00197 0.0166
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
