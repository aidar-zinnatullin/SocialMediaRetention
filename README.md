
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SocialMediaRetention

<!-- badges: start -->
<!-- badges: end -->

`SocialMediaRetention` aims to compute the retention rates for two
cohorts of users (for instance, YouTube commenters who interact with
videos released at different periods). Here is an example:
<https://firstmonday.org/ojs/index.php/fm/article/view/12882>

## Installation

You can install the development version of `SocialMediaRetention` like
so:

``` r
devtools::install_github("aidar-zinnatullin/SocialMediaRetention")
```

## Example

With this package, you can first preprocess social media data by adding
a column that indicates the order of comments for each user based on a
specified time variable.

``` r
library(SocialMediaRetention)
preprocessed_data <- preprocess_comments(test_data, user_id = "authorChannelId", activity_time = "publishedAt")
```

Then, you can identify social media user (e.g., YouTube commenters)
whose first comment was on a video in a specified period of time (e.g.,
treated or control), and who made their first comment within a specified
number of days (parameter `days_after_release`) after the video release.
It then retrieves all comments made by these commenters.

``` r
load("data/treated_hashed_video.RData")
load("data/control_hashed_video.RData")
```

``` r
treated_data <- get_group_data_time(preprocessed_data, group_videos = treated_group, 
                                    days_after_release = 7, activity_time = "publishedAt", 
                                    higher_level_pub_time = "contentDetails.videoPublishedAt", 
                                    higher_level_id =  "Doc_name", user_id = "authorChannelId")
control_data <- get_group_data_time(preprocessed_data, group_videos = control_group, 
                                    days_after_release = 7, activity_time = "publishedAt", 
                                    higher_level_pub_time = "contentDetails.videoPublishedAt", 
                                    higher_level_id =  "Doc_name", user_id = "authorChannelId")
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

The `visualize_retention` command generates a graph that displays
Retention Rates Over Time. The plot showcases how the proportion of
users retained varies across different retention periods (in months) and
compares two groups: Control and Treated. This visualization uses lines
with shaded areas to highlight the trends and differences in user
retention between these groups over a specified timeframe. This tool is
ideal for analyzing the long-term impact of interventions or treatments
on user engagement.

``` r
plot <- visualize_retention(treated_data = progov_treated_yt_n, control_data = progov_control_yt_n)
plot
```

<img src="man/figures/README-pressure-1.png" width="100%" />

## References

1.  Zinnatullin, A. (2023). Navalny’s direct-casting: Affective
    attunement and polarization in the online community of the most
    vocal Russian opposition politician. First Monday,
    <https://firstmonday.org/ojs/index.php/fm/article/view/12882>.
