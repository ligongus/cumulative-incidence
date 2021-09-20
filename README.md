
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cumulative-incidence

The goal of the cumulative-incidence project is to provide a tutorial
for JHS-HWG members who want to create cumulative incidence plots using
`ggplot2`. To demonstrate the code in this repository, we use the
`flchain` data from the `survival` package. These data are loaded and
printed here.

``` r
library(survival)
library(tidyverse)

glimpse(flchain)
#> Rows: 7,874
#> Columns: 11
#> $ age        <dbl> 97, 92, 94, 92, 93, 90, 90, 90, 93, 91, 96, 90, 90, 97, 90,~
#> $ sex        <fct> F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F,~
#> $ sample.yr  <dbl> 1997, 2000, 1997, 1996, 1996, 1997, 1996, 1999, 1996, 1996,~
#> $ kappa      <dbl> 5.700, 0.870, 4.360, 2.420, 1.320, 2.010, 0.430, 2.470, 1.9~
#> $ lambda     <dbl> 4.860, 0.683, 3.850, 2.220, 1.690, 1.860, 0.880, 2.700, 2.1~
#> $ flc.grp    <dbl> 10, 1, 10, 9, 6, 9, 1, 10, 9, 6, 9, 10, 3, 10, 9, 6, 7, 9, ~
#> $ creatinine <dbl> 1.7, 0.9, 1.4, 1.0, 1.1, 1.0, 0.8, 1.2, 1.2, 0.8, 1.3, 1.1,~
#> $ mgus       <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,~
#> $ futime     <int> 85, 1281, 69, 115, 1039, 1355, 2851, 372, 3309, 1326, 2776,~
#> $ death      <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,~
#> $ chapter    <fct> Circulatory, Neoplasms, Circulatory, Circulatory, Circulato~
```
