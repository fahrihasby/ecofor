test_that("IVI works", {
  data <- data.frame(Subplot = rep(1,2),
                     Species = c("Engelhardia spicata Lechen ex Blume",
                                 "Litsea resinosa BIume"),
                     DBH = c(73.370, 13.465))
  result <- dplyr::tibble(Species = c("Engelhardia spicata Lechen ex Blume",
                                   "Litsea resinosa BIume"),
                       Freq_rf = c(50, 50),
                       Kr_rf = c(50,50),
                       Kb_rf = c(96.7, 3.26),
                       IVI = c(197, 103))

  expect_equal(IVI(data), result)
})
