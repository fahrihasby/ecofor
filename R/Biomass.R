#' Biomass calculation according to tree allometry for different reinforest habitat.
#'
#' @param data a data frame or tibble that contains subplot, species, and diamaeter at breast height (DBH, in cm).
#' @param method a climate parameter that detemines the allometry used, \emph{"dry"}, \emph{"moist"}, and \emph{"wet".}
#'
#' @return a tibble containing species name, total diamater at breast height (in cm), and total biomass (in kg).
#'
#' @import dplyr
#' @importFrom rlang .data
#' @export
#'
#' @examples biomass(Papandayan, "moist")
biomass <- function(data, method=c("dry", "moist", "wet")){
  if(method == "dry"){
  W <- data %>%
    left_join(Rho, by = "Species") %>%
    mutate(Height = 9.9412*log(.data$DBH)-11.666,
           Biomass = 0.112*(Rho*(.data$DBH^2)*Height)^0.916) %>%
    group_by(Species) %>%
    summarise(DBH = sum(.data$DBH), Biomass = sum(.data$Biomass)) %>%
    arrange(desc(.data$Biomass))
  W
  } else if (method == "moist"){
    W <- data %>%
      left_join(Rho, by = "Species") %>%
      mutate(Height = 9.9412*log(.data$DBH)-11.666,
             Biomass = 0.0509*(Rho*(.data$DBH^2)*Height)) %>%
      group_by(Species) %>%
      summarise(DBH = sum(.data$DBH), Biomass = sum(.data$Biomass)) %>%
      arrange(desc(.data$Biomass))
    W
  } else {
    W <- data %>%
      left_join(Rho, by = "Species") %>%
      mutate(Height = 9.9412*log(.data$DBH)-11.666,
             Biomass = 0.0776*(Rho*(.data$DBH^2)*Height)^0.94) %>%
      group_by(Species) %>%
      summarise(DBH = sum(.data$DBH), Biomass = sum(.data$Biomass)) %>%
      arrange(desc(.data$Biomass))
    W
  }
}

#' Calculating carbon content in tree based on tree allometry for rainforest habitat.
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
    group_by(.data$Species) %>%
    summarise(Carbon = sum(0.5*.data$Biomass))
  carbon
}

#' Calculating carbon stock in a given area based on tree allometry for rainforest habitat
#' published in Brown, 1997
#'
#' @param data a data frame or tibble that contains subplot, species, and diamaeter at breast height (DBH, in cm).
#' @param plot.size The plot size in m^2. The default value is 100 m^2.
#'
#' @return a tibble containing Subplot name and total carbon content (in ton/ha)
#'
#' @import dplyr
#' @importFrom rlang .data
#' @export
#'
#' @examples carbon.stock(Papandayan)
carbon.stock <- function(data, plot.size=100){
  stock <- data %>%
    group_by(.data$Subplot) %>%
    summarise(Stock = sum(.data$Carbon)/plot.size*10)
  stock
}

#' Estimating height from diameter at breast height measurement
#'
#' @param DBH Measurement of diameter at breast height (cm)
#'
#' @return tree estimated height (in m)
#'
#' @export
#'
#' @examples est.height(5)
est.height <- function(DBH = NULL){
  h <- (9.9412*log(DBH))-11.666
  h
}
