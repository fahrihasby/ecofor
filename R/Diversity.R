#' Diversity indices
#'
#' Shannon-Wiener diversity index (H'), Simpson's diversity index (D), and Simpson's dominance index measures diversity in a given plot/subplot.
#'
#' @param data a data frame or tibble that contains subplot, species, and diamaeter at breast height (DBH, in cm).
#'
#' @return a tibble containing subplot and H' value.
#'
#' @import dplyr
#' @importFrom rlang .data
#' @export
#'
#' @examples diversity(Papandayan)
diversity <- function(data){
  div <- data %>%
    count(.data$Subplot, .data$Species) %>%
    mutate(Pi = n/sum(n), PiLnPi = .data$Pi*log(.data$Pi),) %>%
    group_by(.data$Subplot) %>%
    summarise(H = -sum(.data$PiLnPi),
              D = 1-sum(.data$PiLnPi^2),
              Dominance = sum(.data$PiLnPi^2))
  div
}
