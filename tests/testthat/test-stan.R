# only for debugging
context("Test basic Stan models")
test_stan = TRUE
library(rstan)

test_that("stanmodels exist", {
  expect_true(exists("stanmodels"), "No stanmodels found")
})

test_that("stanmodels$linexp_gastro_1b exists", {
  mod = stanmodels$linexp_gastro_1b
  expect_s4_class(mod, "stanmodel")
  expect_identical(mod@model_name, "linexp_gastro_1b")
  #message(str(mod))
})

gastempt_data = function(){
  set.seed(471)
  d = simulate_gastempt(n_records = 6)$data
  d$record_i =  as.integer(as.factor(d$record))

  list(
    prior_v0 = median(d$vol[d$minute < 10]),
    n = nrow(d),
    n_record = max(d$record_i),
    record = d$record_i,
    minute = d$minute,
    volume = d$vol)
}

test_that("Direct use of sample model returns valid results", {
  skip("Must compile and is slow. Only use on errors in other Stan functions.")
  data = gastempt_data()
  expect_true(file.exists("../../exec/linexp_gastro_1b.stan"))
  rstan_options(auto_write = TRUE)
  mr = stan("../../exec/linexp_gastro_1b.stan", data = data, chain = 1)
  expect_is(mr, "stanfit")
})


test_that("Running precompiled model directly returns valid result", {
  skip_if_not(test_stan)
  mod = stanmodels$linexp_gastro_1b
  testthat::expect_s4_class(mod, "stanmodel")
  testthat::expect_identical(mod@model_name, "linexp_gastro_1b")
  data = gastempt_data()
  fit = rstan::sampling(mod, data = data, chains = 1, iter = 100,
                 show_messages = FALSE)
  expect_is(fit, "stanfit")
})

test_that("Running internal stan_gastempt fit returns valid result", {
  skip_if_not(test_stan)
  set.seed(471)
  d = simulate_gastempt(n_records = 6)
  v0_d = d$record$v0
  ret = stan_gastempt(d$data)
  expect_is(ret, "stan_gastempt")
  # residual standard deviation
  coef = ret$coef
  v0_f = coef[1:length(v0_d)]
  expect_lt(sqrt(var(v0_d - v0_f)), 6)
})

