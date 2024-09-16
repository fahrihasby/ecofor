#' Soil water content
#'
#' @param wet soil wet weight in gram.
#' @param dry soil dry weight in gram.
#' @param container soil container weight in gram.
#' @param data data frame containing edaphic data, measured by gravimetric methods.
#'
#' @return water content in soil in percent.
#' @export
#'
#' @examples water(x, y, data = df)
water <- function(wet, dry, container, data = NULL) {
  wet <- eval(substitute(wet), data, parent.frame())
  dry <- eval(substitute(dry), data, parent.frame())
  alfol <- eval(substitute(alfol), data, parent.frame())
  water <- (dry-alfol)/(wet-alfol)*100
  print(water)
}

#' Soil organic content
#'
#' @param dry soil dry weight in gram.
#' @param ash ash weight in gram.
#' @param crucible  crucible weight in gram.
#' @param data data frame containing edaphic data, measured by gravimetric methods.
#'
#' @return organic content in soil (in percent).
#' @export
#'
#' @examples organic(x, y, z, data = df)
organic <- function(dry, ash, crucible, data = NULL){
  dry <- eval(substitute(dry), data, parent.frame())
  ash <- eval(substitute(ash), data, parent.frame())
  crucible <- eval(substitute(crucible), data, parent.frame())
  organic <- ((dry-crucible)-(ash-crucible))/(dry-crucible)*100
  print(organic)
}

#' Soil mineral content
#'
#' @param dry soil dry weight in gram.
#' @param ash ash weight in gram.
#' @param crucible  crucible weight in gram.
#' @param data data frame containing edaphic data, measured by gravimetric methods.
#'
#' @return mineral content in soil (in percent).
#' @export
#'
#' @examples mineral(x, y, z, data = df)
mineral <- function(dry, ash, crucible, data = NULL){
  dry <- eval(substitute(dry), data, parent.frame())
  ash <- eval(substitute(ash), data, parent.frame())
  crucible <- eval(substitute(crucible), data, parent.frame())
  mineral <- (ash-crucible)/(dry-crucible)*100
  print(mineral)
}

#' Soil bulk density
#'
#' @param dry soil dry weight in gram.
#' @param data data frame containing edaphic data, measured by gravimetric methods.
#' @param d diameter of the core sampler in cm. The default value is 7.62 cm (3").
#' @param h height of the core sampler in cm. The default value is 5 cm.
#'
#' @return Soil bulk density in gram.cm^-3
#' @export
#'
#' @examples bulk(i, data = df)
bulk <- function(dry, data = NULL, d = 7.62, h =5){
  dry <- eval(substitute(dry), data, parent.frame())
  density <- dry/(pi*(0.5*d)^2*h)
  print(density)
}

#' Soil porosity
#'
#' Soil porosity measures the density of pore space in a soil matrix, i.e. the opposite of soil bulk density.
#'
#' @param bulk bulk density in gram.cm^-3.
#' @param type type of soil. Determining the average porosity in the given type, expressed in gram.cm^-3. "low organic" 2,7 gram.cm^-3, "medium organic" 2,65 gram.cm^-3, "high organic" 2,6 gram.cm^-3.
#' @param data data frame containing edaphic data, measured by gravimetric methods.
#'
#' @return Soil porosityin gram.cm^-3.
#' @export
#'
#' @examples pore(j, "high organic", data = df)
pore <- function(
    bulk,
    type = c("low organic",
             "medium organic",
             "high organic"),
    data = NULL){

  if (type == "low organic"){
    pore1 <- 1-(eval(substitute(bulk))/ 2.6)*100
    print(pore1)
  } # low organic content

  if (type == "medium organic"){
    pore2 <- 1-(eval(substitute(bulk))/ 2.65)*100
    print(pore2)
  } #medium organic content

  if (type == "high organic"){
    pore3 <- 1-(eval(substitute(bulk))/ 2.7)*100
    print(pore2)
  } #high organic content
  }
