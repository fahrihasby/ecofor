#' Biomass calculation according to tree allometry for moist habitat in Brown, 1997
#'
#' @param data a data frame or tibble that contains subplot, species, and diamaeter at breast height (DBH, in cm).
#'
#' @return a tibble containing species name, total diamater at breast height (in cm), and total biomass (in kg).
#' @import dplyr
#' @export
#'
#' @examples biomass(Papandayan)
biomass <- function(data){
  W <- data %>%
    mutate(Biomass = 0.118*(.data$DBH^2.53)) %>%
    group_by(.data$Species) %>%
    summarise(DBH = sum(.data$DBH), Biomass = sum(.data$Biomass))
  print(W)
}

#' Calculating carbon content in tree based on biomass calculated with tree allometry for moist habitat
#' published in Brown, 1997.
#'
#' @param data a data frame or tibble that contains subplot, species, and diamaeter at breast height (DBH, in cm).
#' @param C Coefficient for carbon content in a tree.
#'
#' @return a tibble containing species name, total diamater at breast height (in cm), total biomass (in kg),
#' and total carbon content (in kg)
#'
#' @import dplyr
#' @importFrom rlang .data
#' @export
#'
#' @examples carbon(Papandayan)
carbon <- function(data, C = 0.5){
  carbon <- data %>%
    mutate(Biomass = 0.118*(.data$DBH^2.53)) %>%
    group_by(.data$Species) %>%
    summarise(DBH = sum(.data$DBH), Biomass = sum(.data$Biomass), Carbon = sum(0.5*.data$Biomass))
  print(carbon)
}
