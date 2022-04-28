library(testthat)
library(gastempt)
options(Ncpus = parallel::detectCores(logical = TRUE))
test_check("gastempt")
