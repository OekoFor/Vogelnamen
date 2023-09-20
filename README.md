
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Vogelnamen

<!-- badges: start -->
<!-- badges: end -->

This is a data package that contains BirdNET codes, species, family and
order - common and scientific - in german and english all in one place.
Also includes breeding ranges (biogeographical scale).

## Installation

You can install the development version of Vogelnamen from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("OekoFor/Vogelnamen")
```

## Available Datasets

``` r
library(Vogelnamen)

ls.str("package:Vogelnamen") |> print(max.level=0)
#> birdnet_codes_v23 : Classes 'tbl_df', 'tbl' and 'data.frame':    3337 obs. of  12 variables:
#> birdnet_codes_v24 : Classes 'tbl_df', 'tbl' and 'data.frame':    6522 obs. of  12 variables:
#> breedingrange_codes : Classes 'tbl_df', 'tbl' and 'data.frame':  13 obs. of  5 variables:
#> voegel_der_erde : Classes 'tbl_df', 'tbl' and 'data.frame':  10929 obs. of  9 variables:
```

## Skim Datasets

### birdnet codes

``` r
# For column descriptions of the datasets see
# ?birdnet_codes_v23
```

``` r
skimr::skim(birdnet_codes_v24)
```

|                                                  |                   |
|:-------------------------------------------------|:------------------|
| Name                                             | birdnet_codes_v24 |
| Number of rows                                   | 6522              |
| Number of columns                                | 12                |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |                   |
| Column type frequency:                           |                   |
| character                                        | 12                |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |                   |
| Group variables                                  | None              |

Data summary

**Variable type: character**

| skim_variable    | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:-----------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| sciName          |         0 |          1.00 |   3 |  33 |     0 |     6522 |          0 |
| comName          |         0 |          1.00 |   3 |  34 |     0 |     6522 |          0 |
| comName_de       |         0 |          1.00 |   3 |  34 |     0 |     6522 |          0 |
| speciesCode      |         0 |          1.00 |   4 |  10 |     0 |     6522 |          0 |
| breedingRange    |       127 |          0.98 |   2 |  19 |     0 |       62 |          0 |
| orderSciName     |       101 |          0.98 |  10 |  19 |     0 |       39 |          0 |
| orderComName_de  |       101 |          0.98 |   5 |  19 |     0 |       39 |          0 |
| familySciName    |       101 |          0.98 |   7 |  18 |     0 |      235 |          0 |
| familyComName_de |       101 |          0.98 |   4 |  23 |     0 |      235 |          0 |
| familyComName    |       101 |          0.98 |   4 |  36 |     0 |      235 |          0 |
| group            |         0 |          1.00 |   5 |  10 |     0 |        5 |          0 |
| group_de         |         0 |          1.00 |   5 |  10 |     0 |        5 |          0 |

### breeding range codes

``` r
skimr::skim(breedingrange_codes)
```

|                                                  |                     |
|:-------------------------------------------------|:--------------------|
| Name                                             | breedingrange_codes |
| Number of rows                                   | 13                  |
| Number of columns                                | 5                   |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |                     |
| Column type frequency:                           |                     |
| character                                        | 5                   |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |                     |
| Group variables                                  | None                |

Data summary

**Variable type: character**

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:--------------|----------:|--------------:|----:|----:|------:|---------:|-----------:|
| breedingRange |         0 |          1.00 |   2 |   3 |     0 |       13 |          0 |
| en            |         0 |          1.00 |   6 |  18 |     0 |       13 |          0 |
| de            |         0 |          1.00 |   6 |  18 |     0 |       13 |          0 |
| comment_en    |        12 |          0.08 |   0 |   0 |     1 |        1 |          0 |
| comment_de    |         6 |          0.54 |  10 | 174 |     0 |        7 |          0 |

``` r

breedingrange_codes |> 
  knitr::kable()
```

| breedingRange | en                 | de                 | comment_en | comment_de                                                                                                                                                                     |
|:--------------|:-------------------|:-------------------|:-----------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| AF            | Africa             | Afrika             |            | Afrotropis einschließlich Nordafrika und Madagaskar                                                                                                                            |
| AN            | Antarctis          | Antarktis          | NA         | NA                                                                                                                                                                             |
| AU            | Australasian realm | Australis          | NA         | Australasien, also Wallacea östlich der Wallace-Linie, Neuguinea, Australien, Neuseeland einschließlich seiner Subantark- tischen Inseln, Salomonen, Neukaledonien und Vanuatu |
| MA            | central america    | Mittelamerika      | NA         | Mexiko bis Panama                                                                                                                                                              |
| NA            | Nearctic realm     | Nearktis           | NA         | Nordamerika einschließlich Karibik                                                                                                                                             |
| OR            | Indomalayan realm  | Orientalis         | NA         | Südasien einschließlich der Inseln ostwärts bis zu den Großen Sundainseln                                                                                                      |
| PAL           | Palearctic realm   | Paläarktis         | NA         | Europa, Naher Osten, Nordasien einschließlich der sino-japanischen Region, Grönland und arktische Inseln, jedoch ohne Nordafrika                                               |
| SA            | Neotroprical realm | Neotropis          | NA         | Südamerika                                                                                                                                                                     |
| AO            | Atlantic ocean     | Atlantischer Ozean | NA         | NA                                                                                                                                                                             |
| IO            | Indian ocean       | Indischer Ozean    | NA         | NA                                                                                                                                                                             |
| TrO           | tropical oceans    | tropische Ozeane   | NA         | NA                                                                                                                                                                             |
| NO            | northern oceans    | nördliche Ozeane   | NA         | NA                                                                                                                                                                             |
| SO            | southern oceans    | südliche Ozeane    | NA         | NA                                                                                                                                                                             |

## Data sources

Missing 😙
