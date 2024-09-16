#' Biomass calculation according to tree allometry for moist habitat in Brown, 1997
#'
#' @param data a data frame or tibble that contains subplot, species, and diamaeter at breast height (DBH, in cm).
#'
#' @returna a tibble containing species name, total diamater at breast height (in cm), and total biomass (in kg).
#' @import dplyr
#' @export
#'
#' @examples biomass(Papandayan)
biomass <- function(data){
  W <- Papandayan %>%
    mutate(Biomass = 0.118*(DBH^2.53)) %>%
    group_by(Species) %>%
    summarise(DBH = sum(DBH), Biomass = sum(Biomass))
  W
}

#' Calculating carbon content in tree based on biomass calculated with tree allometry for moist habitat in Brown, 1997
#'
#' @param data a data frame or tibble that contains subplot, species, and diamaeter at breast height (DBH, in cm).
#' @param C Coefficient for carbon content in a tree.
#'
#' @return a tibble containing species name, total diamater at breast height (in cm), total biomass (in kg), and total carbon content (in kg)
#' @import dplyr
#' @export
#'
#' @examples carbon (Papandayan)
carbon <- function(data, C = 0.5){
  carbon <- Papandayan %>%
    mutate(Biomass = 0.118*(DBH^2.53)) %>%
    group_by(Species) %>%
    summarise(DBH = sum(DBH), Biomass = sum(Biomass), Biomass)
  carbon
}
