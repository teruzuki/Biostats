library(devtools)
install.packages("RCurl")
install.packages("here")
library(RCurl)
library(here)
install_github("brouwern/mammalsmilk")
#install.packages("mammalsmilkRA")

library(dplyr)  # for exploratory analyses
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(ggpubr) # plotting using ggplto2
#> Loading required package: ggplot2
#> Loading required package: magrittr
library(cowplot)
#> 
#> Attaching package: 'cowplot'
#> The following object is masked from 'package:ggpubr':
#> 
#>     get_legend
#> The following object is masked from 'package:ggplot2':
#> 
#>     ggsave
library(lme4)
#> Loading required package: Matrix
library(arm)
#> Loading required package: MASS
#> 
#> Attaching package: 'MASS'
#> The following object is masked from 'package:dplyr':
#> 
#>     select
#> 
#> arm (Version 1.10-1, built: 2018-4-12)
#> Working directory is C:/Users/lisanjie/Documents/1_R/git/mammalsmilkRA/vignettes
library(stringr) 
library(bbmle)
#> Loading required package: stats4
#> 
#> Attaching package: 'bbmle'
#> The following object is masked from 'package:dplyr':
#> 
#>     slice
library(plotrix) ##std.error function for SE
#> 
#> Attaching package: 'plotrix'
#> The following object is masked from 'package:arm':
#> 
#>     rescale
library(psych)
