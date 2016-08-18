library(testthat)
library(gastempt)

test_check("gastempt", filter = "stan", perl = TRUE)

