# only for debugging
if (FALSE) {
  library(testthat)
  library(ggplot2)
  library(assertthat)
  library(dplyr)
  library(Rcpp)
  library(gastempt)
  suppressPackageStartupMessages(library(rstan))
}
context("Test basic Stan models")

test_that("stanmodels exist", {
  expect_true(exists("stanmodels"), "No stanmodels found")
})

test_that("stanmodels$linexp_gastro_1b exists", {
  expect_silent(stanmodels$linexp_gastro_1b)
})

test_that("Basic direct use of sample model returns valid results", {
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
  model = stanmodels$linexp_gastro_1b
  mr_stan <- sampling(model, chains = 1, iter = 1000, data = data)
  expect_s4_class(mr_stan, "stanfit")

  ss  = summary(mr_stan, "v0")$summary[,1]
  # residual standard deviation
  expect_lt(sqrt(var(ss - s$record$v0)), 7)
})

