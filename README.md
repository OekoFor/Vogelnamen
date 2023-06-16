
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Vogelnamen

<!-- badges: start -->
<!-- badges: end -->

THis is a data package that contains BirdNET codes, species, family and
order - common and scientific - in german and english all in one place.
Also includes breeding ranges (biogeographical scale).

## Installation

You can install the development version of Vogelnamen from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("OekoFor/Vogelnamen")
```

## Example

``` r
library(Vogelnamen)

# see `?birdnet_codes_v23` for column descriptions
skimr::skim(birdnet_codes_v23)
```

|                                                  |                   |
|:-------------------------------------------------|:------------------|
| Name                                             | birdnet_codes_v23 |
| Number of rows                                   | 3337              |
| Number of columns                                | 11                |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |                   |
| Column type frequency:                           |                   |
| character                                        | 11                |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |                   |
| Group variables                                  | None              |

Data summary

**Variable type: character**

| skim_variable    | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:-----------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| sciName          |         0 |          1.00 |   3 |  33 |     0 |     3337 |          0 |
| comName          |         0 |          1.00 |   3 |  34 |     0 |     3337 |          0 |
| comName_de       |         0 |          1.00 |   3 |  34 |     0 |     3337 |          0 |
| speciesCode      |         0 |          1.00 |   4 |  10 |     0 |     3337 |          0 |
| breedingRange    |       110 |          0.97 |   2 |  19 |     0 |       52 |          0 |
| orderSciName     |       101 |          0.97 |  10 |  19 |     0 |       34 |          0 |
| orderComName_de  |       101 |          0.97 |   5 |  19 |     0 |       34 |          0 |
| familySciName    |       101 |          0.97 |   7 |  17 |     0 |      187 |          0 |
| familyComName_de |       101 |          0.97 |   4 |  23 |     0 |      187 |          0 |
| familyComName    |       101 |          0.97 |   4 |  36 |     0 |      187 |          0 |
| type             |         0 |          1.00 |   4 |   9 |     0 |        5 |          0 |

## Data sources

Missing 😙
