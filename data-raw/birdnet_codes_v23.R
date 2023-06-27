## code to prepare `birdnet_codes_v23` dataset goes here
library(dplyr)
library(magrittr)

# Load Data -------------------------------------------------------------------------------------------------------

load(file = "data/voegel_der_erde.rda")

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


ebirdtax <- rebird::ebirdtaxonomy()


# Join ------------------------------------------------------------------------------------------------------------
# create dataset only for BirdNET detectable species

# join german translations from analyzer repo and species codes
birdnet_codes <-
  BirdNET_GLOBAL_3K_V2_3_Labels |>
  dplyr::left_join(BirdNET_GLOBAL_3K_V2_3_Labels_DE) |>
  dplyr::left_join(eBird_taxonomy_codes_2021E)


# join breeding range and order/family in german and english based on Voegel der Erde
# We need to do this in multiple steps because neither scientific, nor english or german names match 100%
# but for most species 1 of them matches.
# 1) left join on scientific names produces the most certain matches (certainty = 1).
#     This joins Order and family names in english and german and breeding range
#     where breedingRange is NA, nothing was matched
# 2/3) patch rows based on english and german name (scientific name is different, certainty = 2)
# 4) patch only scientific familiy and order with existing species code from ebird taxonomy (no match from voegel der erde)
# 5) patch german names and common english family again from voegel der erde
# 6) include variable 'type' to identify birds
# 7) manually identify other classes (events, mammals, insects, amphibians) and patch 'type'



birdnet_codes_with_meta <-
  birdnet_codes |>
  dplyr::left_join(select(voegel_der_erde, -comName, -comName_de)) %T>% {
    print(sum(is.na(.$breedingRange)))
  } %>%
  rows_patch(voegel_der_erde,
             by = "comName",
             unmatched = "ignore")  %T>% {
               print(sum(is.na(.$breedingRange)))
             } %>%
  rows_patch(voegel_der_erde,
             by = "comName_de",
             unmatched = "ignore")  %T>% {
               print(sum(is.na(.$breedingRange)))
             } %>%
  rows_patch(
    select(ebirdtax, speciesCode, familySciName, "orderSciName" = order),
    by = "speciesCode",
    unmatched = "ignore"
  ) |>
  rows_patch(
    distinct(
      select(
        voegel_der_erde,
        orderSciName,
        orderComName_de,
        familyComName,
        familySciName,
        familyComName_de
      )
    ),
    by = c("orderSciName", "familySciName"),
    unmatched = "ignore"
  ) |>
  mutate(type = if_else(is.na(orderSciName), NA, "bird")) |>
  identity()



# Custom list Non-bird Classes-----------------------------------------------------------------------------------------------------
other <- tibble(
  "speciesCode" = c("dogdog", "engine", "envrnm", "frwrks", "gungun", "nocall", "powtoo", "siren1", "humwhi", "humvoc", "humnov"),
  "type" = "other"
)

mammal <- tibble(
  "comName" = c("Coyote", "Gray Wolf", "Eastern Gray Squirrel", "Red Squirrel", "Eastern Chipmunk", "Mexican Black Howler Monkey", "White-tailed Deer"),
  "type" = "mammal"
)

amphibians <-
  birdnet_codes_with_meta |>
  filter(
    grepl("frog|toad", x = comName, ignore.case = TRUE) & is.na(orderSciName) |
    sciName %in% c("Pseudacris crucifer", "Scaphiopus couchii", "Spea bombifrons")
    ) |>
  select(sciName, comName) |>
  mutate(type = "amphibian")
# View(amphibians)

insects <-
  birdnet_codes_with_meta |>
  dplyr::filter(
    grepl("cricket|katydid|conehead|bee|gryllus|trig", x = comName, ignore.case = TRUE) & is.na(orderSciName) |
    sciName %in% c("Atlanticus testaceus", "Microcentrum rhombifolium")
    ) |>
  select(sciName, comName) |>
  mutate(type = "insect")
# View(insects)

# birdnet_codes_with_meta |>
#   dplyr::filter(is.na(orderSciName)) |>
#   View()


birdnet_codes_v23 <-
  birdnet_codes_with_meta |>
  dplyr::rows_patch(other) |>
  dplyr::rows_patch(mammal) |>
  dplyr::rows_patch(amphibians) |>
  dplyr::rows_patch(insects)

# birdnet_codes_v23 |>
#   dplyr::filter(is.na(orderSciName)) |>
#   View()


# Translate groups ------------------------------------------------------------------------------------------------

translation_groups <- tibble::tribble(
  ~type, ~type_de,
  "bird", "Vogel",
  "amphibian", "Amphib",
  "insect", "Insekt",
  "mammal", "Säugetier",
  "other", "weitere"
)

birdnet_codes_v23 <-
  dplyr::left_join(birdnet_codes_v23, translation_groups)



# Save ------------------------------------------------------------------------------------------------------------

usethis::use_data(birdnet_codes_v23, overwrite = TRUE)
