library(pdftools)
library(dplyr)
library(purrr)
library(tidyr)
library(tidyselect)
library(stringr)


birdnames_pdf <- pdftools::pdf_data("data-raw/Vogelwarte_58_2020_0001-0214.pdf")

pdf_import_to_table <- function(lst) {
  lst |>
    select(x,y,text) |>
    pivot_wider(names_from = x, values_from = text) |>
    arrange(y) |>
    # mitigate small differences in x values (row position)
    mutate(y_lag = lag(y), .after = "y") |>
    mutate(y_delta = y - y_lag, .after = "y_lag") |>
    mutate(y_new = if_else(y_delta < 5, y_lag, y), .after = "y_delta") |>
    select(-y, -y_lag, -y_delta) |>
    pivot_longer(cols = !starts_with("y"), names_to = "x") |>
    drop_na() |>
    arrange(y_new, x) |>
    filter(y_new > 40, y_new < 700) |>
    mutate(x = as.numeric(x)) |>
    mutate(new_col = case_when(
      x < 185 ~ "col_1",
      x > 185 & x < 300 ~ "col_2",
      x > 300 & x < 420 ~ "col_3",
      x > 420 ~ "col_4"
    )) |>
    select(y_new, value, new_col) |>
    pivot_wider(names_from = new_col, values_from = value, values_fn = list) |>
    select(y_new, num_range("col_", range = 1:4))
}

common_name <- function(x, y) {
  if (x) {
    paste(y, collapse = " ")
  } else {
    NA_character_
  }
}

sci_name <- function(x, y) {
  if (x) {
    stringr::str_to_title(y[2])
  } else {
    NA_character_
  }
}

# turn pdf import lists into usable table with proper line and column separation
# remove first row (some header)
birds_table <-
  birdnames_pdf[10:length(birdnames_pdf)] |>
  purrr::map_dfr(pdf_import_to_table) |>
  slice(2:length(col_1))

# 1) tidy family and order names. fill rows
# 2) remove rows that were family or order only and their respecrtive bool columns
# 3) collapse list columns
# 4) rename columns
# 5) clean special characters
voegel_der_erde <-
  birds_table |>
  mutate("is_family" =  map_lgl(col_2, ~ has_element(.x, "Familie"))) |>
  mutate("is_order" =  map_lgl(col_2, ~ has_element(.x, "ORDNUNG"))) |>
  mutate(
    "orderSciName" = map2_chr(is_order, col_2, sci_name),
    "orderComName_de" = map2_chr(is_order, col_1, common_name),
    "familySciName" =  map2_chr(is_family, col_2, sci_name),
    "familyComName_de" = map2_chr(is_family, col_1, common_name),
    "familyComName" = map2_chr(is_family, col_3, common_name)
  ) |>
  tidyr::fill(contains("Name"), .direction = "down") |>
  filter(!is_family & !is_order) |>
  select(-is_family, -is_order, -y_new) |>
  mutate(across(where(is.list), ~map_chr(.x, function(x){
    unlist(x) |>
      paste(collapse = " ")
  }))) |>
  rename("comName_de" = col_1, "sciName" = col_2, "comName" = col_3, "breedingRange" = col_4) |>
  mutate(across(where(is.character), ~gsub(pattern = "‘", replacement = "'", x = .x)))

#View(voegel_der_erde)


# Save ------------------------------------------------------------------------------------------------------------

usethis::use_data(voegel_der_erde, overwrite = TRUE)


