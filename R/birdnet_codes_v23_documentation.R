#' BirdNET v2.3 labels extended
#'
#' This dataset combines the common and scientific names and their repsective species codes for all species (and classes)
#' that are detectable with BirdNET v2.3.
#' It introduces a 'type' column: it identifies birds, mammals, amphibians, insects and other event classes.
#' For birds, the dataset includes the scientific and common names (and the german translation) of the order and family
#' and the breeding range.
#' If no german translation was available, the english common name was used.
#' Column names were chosen to maximize the compatibility with the {rebird} package.
#'
#'
#'
#'
#' @format ## `birdnet_codes_v23`
#' A data frame with 3,337 rows and 12 columns:
#' \describe{
#'   \item{sciName}{scientific names}
#'   \item{comName}{common names}
#'   \item{comName_de}{common names in german}
#'   \item{speciesCode}{eBird species codes}
#'   \item{breedingRange}{breeding ranges (abbrv.). AF (Africa), AN (Antarctis), AU (Australis), MA (central america), NA (Nearctic), OR (Orientalis, Indomalayan), PAL (Palearctic), SA (Southamerica, Neotropics). Oceanic regions and their islands: AO (Atlantic), PO (Pacific), IO (Indian Ocean), TrO (Tropical), TO (Temperate), NO (Northern), and SO (Southern Oceans). For more details see Voegel der Erde 2020}
#'   \item{orderSciName}{scientific names of order}
#'   \item{orderComName_de}{common names of order in german}
#'   \item{familySciName}{scientific names of family}
#'   \item{familyComName}{common names of family}
#'   \item{familyComName_de}{common names of family in german}
#'   \item{group}{identifies birds, mammals, amphibians, insects and other event classes}
#'   \item{group_de}{column type in german}
#' }
#' @source <http://www.do-g.de/fileadmin/Vogelwarte_58_2020-1__DO-G_Dt_Namen_Voegel_d_Erde.pdf>
#' @source <https://github.com/kahst/BirdNET-Analyzer>
"birdnet_codes_v23"
