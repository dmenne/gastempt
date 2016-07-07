# only for debugging
context("Test basic Stan models")

if (FALSE){
  library(rstan)
  library(testthat)
  library(gastempt)
  library(assertthat)
}

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
  simulate_gastempt(n_records = 6, seed = 471)$stan_data
}

test_that("Direct use of sample model returns valid results", {
  skip("This test must compile the model and is slow. Only use on errors in other Stan functions.")
  data = gastempt_data()
  stan_model = "../../exec/linexp_gastro_1b.stan"
  expect_true(file.exists(stan_model))
  rstan_options(auto_write = TRUE)
  iter = 500
  cap = capture_output({
    mr_b =  suppressWarnings(
      stan(stan_model, data = data, chains = 4, iter = iter,
               seed = 4711, refresh = FALSE))
  })
  expect_is(mr_b, "stanfit")

  stan_model = "../../exec/linexp_gastro_1c.stan"
  mr_c = stan(stan_model, data = data, chains = 4, iter = iter,
              seed = 4711, refresh = FALSE)

  stan_model = "../../exec/linexp_gastro_1d.stan"
  mr_d = stan(stan_model, data = data, chains = 4, iter = iter,
              seed = 4711, refresh = FALSE)

  m_d = get_posterior_mean(mr_d)[,5];
  m_c = get_posterior_mean(mr_c)[,5];
  m_b = get_posterior_mean(mr_b)[,5];
  cbind(m_b, m_c, m_c)

  sum(get_elapsed_time(mr_b))
  sum(get_elapsed_time(mr_c))
  sum(get_elapsed_time(mr_d))
})


run_precompiled_model = function(model){
  mod = stanmodels[[model]]
  testthat::expect_s4_class(mod, "stanmodel")
  testthat::expect_identical(mod@model_name, model)
  data = gastempt_data()
  cap = capture_output({
    fit = suppressWarnings(
      rstan::sampling(mod, data = data, chains = 1, iter = 500,                            refresh = -1, verbose = FALSE))
  })
  expect_is(fit, "stanfit")
}


test_that("Running precompiled model directly returns valid result", {
  run_precompiled_model("linexp_gastro_1b")
  run_precompiled_model("linexp_gastro_1c")
  run_precompiled_model("linexp_gastro_1d")
})

test_that("Running internal stan_gastempt fit returns valid result", {
  set.seed(471)
  d = simulate_gastempt(n_records = 6)
  v0_d = d$rec$v0
  ret = stan_gastempt(d$data, model_name = "linexp_gastro_1c", refresh = -1)
  expect_is(ret, "stan_gastempt")
  # residual standard deviation
  coef = ret$coef
  v0_f = coef[1:length(v0_d)]
  expect_lt(sqrt(var(v0_d - v0_f)), 6)
})

test_that("Running internal stan_gastempt with many missing data returns valid result", {
  set.seed(471)
  d = simulate_gastempt(n_records = 6, missing = 0.3)
  v0_d = d$rec$v0
  ret = stan_gastempt(d$data, model_name = "linexp_gastro_1c", refresh = -1)
  expect_is(ret, "stan_gastempt")
  # residual standard deviation
  coef = ret$coef
  v0_f = coef[1:length(v0_d)]
  expect_lt(sqrt(var(v0_d - v0_f)), 8)
})

