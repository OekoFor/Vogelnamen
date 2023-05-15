## code to prepare `birdnet_codes_v23` dataset goes here


# Load Data -------------------------------------------------------------------------------------------------------

# species that BirdNET is trained on
# scientific and common names in ennglisch
BirdNET_GLOBAL_3K_V2_3_Labels <-
  readr::read_csv("data-raw/BirdNET_GLOBAL_3K_V2.3_Labels.txt",
                  col_names = "name") |>
  tidyr::separate_wider_delim(
    cols = name,
    delim = "_",
    names = c("sciName", "comName")
  )

# scientific and common names in ennglisch
BirdNET_GLOBAL_3K_V2_3_Labels_DE <-
  readr::read_csv("data-raw/BirdNET_GLOBAL_3K_V2.3_Labels_de.txt",
                  col_names = "name") |>
  tidyr::separate_wider_delim(
    cols = name,
    delim = "_",
    names = c("sciName", "comName_de")
  )

# ebird species code compatible with names/codes used to train BirdNET
eBird_taxonomy_codes_2021E <-
  jsonlite::read_json("data-raw/eBird_taxonomy_codes_2021E.json",
                      simplifyVector = TRUE) |>
  unlist() |>
  tibble::enframe(name = "name", value = "speciesCode") |>
  dplyr::filter(grepl("_", name)) |>
  tidyr::separate_wider_delim(
    cols = name,
    delim = "_",
    names = c("sciName", "comName")
  )


ebirdtaxonomy <- ebirdtaxonomy()
View(ebirdtaxonomy)
com_fams <- unique(ebirdtaxonomy$familyComName)
com_fams |> sort() |>

# Join ------------------------------------------------------------------------------------------------------------
# create dataset only for BirdNET detectable species

birdnet_codes_v23 <-
  BirdNET_GLOBAL_3K_V2_3_Labels |>
  dplyr::left_join(BirdNET_GLOBAL_3K_V2_3_Labels_DE) |>
  dplyr::left_join(eBird_taxonomy_codes_2021E)

birdnet_codes_v23



# Save ------------------------------------------------------------------------------------------------------------

usethis::use_data(birdnet_codes_v23, overwrite = TRUE)
