## code to prepare `breedingrange_codes` dataset goes here
library(tibble)


breedingrange_codes <- tibble::tribble(
  ~breedingRange, ~en, ~de, ~comment_en, ~comment_de,
  "AF", "Africa", "Afrika", "", "Afrotropis einschließlich Nordafrika und Madagaskar",
  "AN", "Antarctis", "Antarktis", NA, NA,
  "AU", "Australasian realm", "Australis", NA, "Australasien, also Wallacea östlich der Wallace-Linie, Neuguinea, Australien, Neuseeland einschließlich seiner Subantark- tischen Inseln, Salomonen, Neukaledonien und Vanuatu",
  "MA", "central america", "Mittelamerika", NA, "Mexiko bis Panama",
  "NA", "Nearctic realm", "Nearktis", NA, "Nordamerika einschließlich Karibik",
  "OR", "Indomalayan realm", "Orientalis", NA, "Südasien einschließlich der Inseln ostwärts bis zu den Großen Sundainseln",
  "PAL", "Palearctic realm", "Paläarktis", NA, "Europa, Naher Osten, Nordasien einschließlich der sino-japanischen Region, Grönland und arktische Inseln, jedoch ohne Nordafrika",
  "SA", "Neotroprical realm", "Neotropis", NA, "Südamerika",
  "AO", "Atlantic ocean", "Atlantischer Ozean", NA, NA,
  "IO", "Indian ocean", "Indischer Ozean", NA, NA,
  "TrO", "tropical oceans", "tropische Ozeane", NA, NA,
  "NO", "northern oceans", "nördliche Ozeane", NA, NA,
  "SO", "southern oceans", "südliche Ozeane", NA, NA
)

#AF (Africa), AN (Antarctis), AU (Australis), MA (central america), NA (Nearctic), OR (Orientalis, Indomalayan), PAL (Palearctic), SA (Southamerica, Neotropics). Oceanic regions and their islands: AO (Atlantic), PO (Pacific), IO (Indian Ocean), TrO (Tropical), TO (Temperate), NO (Northern), and SO (Southern Oceans)



usethis::use_data(breedingrange_codes, overwrite = TRUE)
