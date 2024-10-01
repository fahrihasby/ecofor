#' Calculate soil properties
#'
#' @param data a data frame or tibble containing soil measurements with gravimetric methods
#' @param d diameter of the core sampler. The default value is 7.62 cm (2 inch).
#' @param h height of the core sampler. The default value is 2 cm.
#'
#' @return a tibble of the original input data together with soil bulk density, water content (%), organic content (%), and mineral content(%).
#'
#' @import dplyr
#' @importFrom rlang .data
#' @export
#'
#' @examples edaphic(Edaphic_data)

edaphic <- function(data, d = 7.62, h = 5) {
  result <- data %>% mutate(
    Bulk = (.data$Core_Wet-.data$Core_Dry)/(pi*(d/2)^2*h),
    Water_prct = (.data$Core_Wet-.data$Core_Dry)/.data$Core_Wet*100,
    Organic_prct = ((.data$Cru_Dry-.data$Crucible)-(.data$Cru_Ash-.data$Crucible))/(.data$Cru_Dry-.data$Crucible)*100,
    Mineral_prct = (.data$Cru_Ash-.data$Crucible)/(.data$Cru_Dry-.data$Crucible)*100
    )
  result
}
