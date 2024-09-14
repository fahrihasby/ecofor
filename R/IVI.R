#' Analyze IVI from DBH data
#'
#' Importance value index (IVI) measures how dominant a species is in a given forest area.
#'
#' @param data a data frame or tibble that contains subplot, species, and diamaeter at breast height (DBH, in cm).
#' @param plot.size The plot size in m^2. The default value is 100 m^2.
#' @param n.subplot The number of subplot. The default value is 5.
#' @returns a tibble containing species name, relative frequency, relative density, relative coverage, and importance value index.
#' @import dplyr
#' @export
#'
#' @examples
IVI <- function(data, plot.size = 100, n.subplot=5){
  result <- data %>%
    group_by(Species) %>%
    mutate(LAB = pi*(0.5*DBH)^2) %>%
    summarise(Freq_rf = n_distinct(Subplot)/n.subplot,
              Kr_rf = n()/100,
              Kb_rf = sum(LAB)) %>%
    mutate_if(is.numeric,.funs = ~./sum(.)*100) %>%
    mutate(IVI = Freq_rf + Kr_rf + Kb_rf) %>%
    arrange(desc(IVI))
}
