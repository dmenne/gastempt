# only for debugging
if (TRUE) {
  library(testthat)
  library(ggplot2)
  library(assertthat)
  library(dplyr)
  library(Rcpp)
  library(gastempt)
  suppressPackageStartupMessages(library(rstan))
}


context("Test basic Stan models")
#loadModule("gastempt", TRUE)

test_that("Basic direct use of Stan returns valid results", {
  set.seed(471)
  s = simulate_gastempt(n_records = 6)
  mr = s$data %>%
    mutate(
      record_i = as.integer(as.factor(record))
    )
  prior_v0 = mr %>%  filter(minute == 0) %>%
    summarize(
      v0 = median(vol)
    )
  n_record = max(mr$record_i)
  rstan_options(auto_write = TRUE)
  options(mc.cores = parallel::detectCores())


  data = list(
    prior_v0 = unlist(prior_v0$v0),
    n = nrow(mr),
    n_record = n_record,
    record = mr$record_i,
    minute = mr$minute,
    volume = mr$vol)

  expect_output(mr_stan <- sampling(linexpgastro_1b,
       chains = 1, iter = 1000, data = data, seed = 4711),
    "do not ask")
  ss  = summary(mr_stan, "v0")$summary[,1]
  # residual standard deviation
  expect_lt(sqrt(var(ss- s$record$v0)), 7)
})

