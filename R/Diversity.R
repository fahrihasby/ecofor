#' Diversity indices
#'
#'Shannon-Wiener diversity index (H'), Simpson's diversity index (D), and Simpson's dominance index measures diversity in a given plot/subplot.
#'
#' @param data a data frame or tibble that contains subplot, species, and diamaeter at breast height (DBH, in cm).
#'
#' @return a tibble containing subplot and H' value.
#' @export
#'
#' @examples diversity(Papandayan)
diversity <- function(data){
  div <- data %>%
    count(Subplot, Species) %>%
    mutate(Pi = n/sum(n), PiLnPi = Pi*log(Pi),) %>%
    group_by(Subplot) %>%
    summarise(H = -sum(PiLnPi),
              D = 1-sum(PiLnPi^2),
              Dominance = sum(PiLnPi^2))
  div
}
