context("Test basic Stan models")

# only for debugging
if (FALSE) {
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

if (FALSE)
test_that("Direct use of sample model returns valid results", {
  # This test must compile the model and is slow.
  # Only use on errors in other Stan functions.
  data = gastempt_data()
  stan_model = "../../exec/linexp_gastro_2b.stan"
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
  cat("Testing ", model,"\n") # Generate output for travis
  mod = stanmodels[[model]]
  testthat::expect_s4_class(mod, "stanmodel")
  testthat::expect_identical(mod@model_name, model)
  data = gastempt_data()
  data$lkj = 2
  data$student_df = 5
  cap = capture_output({
    fit = suppressWarnings(
      rstan::sampling(mod, data = data, chains = 2, iter = 500,                            refresh = -1, verbose = FALSE))
  })
  expect_is(fit, "stanfit")
}

test_that("Running precompiled models linexp _1x directly returns valid result", {
  skip_on_travis()
  run_precompiled_model("linexp_gastro_1b")
  run_precompiled_model("linexp_gastro_1c")
  run_precompiled_model("linexp_gastro_1d")
})

test_that("Running precompiled linexp models _2x directly returns valid result", {
  skip_on_travis()
  run_precompiled_model("linexp_gastro_2b")
  run_precompiled_model("linexp_gastro_2c")
})

test_that("Running precompiled powexp models _2x directly returns valid result", {
  skip_on_travis()
  run_precompiled_model("powexp_gastro_2c")
})


test_that("Running internal stan_gastempt fit with default parameters and multiple cores returns valid result", {
  #skip_on_travis()
  #cat("Multiple cores\n")
  d = simulate_gastempt(n_records = 6, seed = 471)
  v0_d = d$rec$v0
  rstan_options(auto_write = TRUE)
  chains = 1
  options(mc.cores = min(parallel::detectCores(), chains))
  ret = stan_gastempt(d$data, model_name = "linexp_gastro_2b",
                      chains = chains, refresh = -1, iter = 500)
  expect_is(ret, "stan_gastempt")
  expect_is(ret$plot, "ggplot")
  expect_s4_class(ret$fit, "stanfit")
  # residual standard deviation
  v0_f = ret$coef$v0
  expect_lt(sqrt(var(v0_d - v0_f)), 8)
  expect_true(all(c("sigma", "mu_kappa", "sigma_kappa", "lp") %in%
                    names(attributes(ret$coef))))
})


test_that("Running internal stan_gastempt with powexp returns valid result", {
  #skip_on_travis()
  cat("Powexp cores\n")
  options(mc.cores = 1)
  d = simulate_gastempt(n_records = 6, seed = 471, model = powexp,
                        beta_mean = 2.5, missing = 0.3, iter = 500)
  v0_d = d$rec$v0
  ret = stan_gastempt(d$data, model_name = "powexp_gastro_2c", refresh = -1)
  expect_is(ret, "stan_gastempt")
  expect_is(ret$plot, "ggplot")
  expect_s4_class(ret$fit, "stanfit")
  # residual standard deviation
  v0_f = ret$coef$v0
  expect_lt(sqrt(var(v0_d - v0_f)), 20)
  expect_true(all(c("sigma", "mu_beta", "sigma_beta", "lp") %in%
                    names(attributes(ret$coef))))
})



test_that("Running internal stan_gastempt fit with non-default parameters returns valid result", {
  skip_on_travis()
  d = simulate_gastempt(n_records = 6, seed = 471)
  v0_d = d$rec$v0
  ret = stan_gastempt(d$data, model_name = "linexp_gastro_2c", refresh = -1,
                      chains = 2, init_r = 0.3)
  expect_is(ret, "stan_gastempt")
  v0_f = ret$coef$v0
  expect_lt(sqrt(var(v0_d - v0_f)), 8)
})

test_that("Running internal stan_gastempt with many missing data returns valid result", {
  cat("Missing data\n")
  d = simulate_gastempt(n_records = 6, missing = 0.3, seed = 471)
  v0_d = d$rec$v0
  ret = stan_gastempt(d$data, model_name = "linexp_gastro_1c", refresh = -1)
  expect_is(ret, "stan_gastempt")
  expect_is(ret$plot, "ggplot")
  expect_s4_class(ret$fit, "stanfit")
  # residual standard deviation
  v0_f = ret$coef$v0
  expect_lt(sqrt(var(v0_d - v0_f)), 8)
  expect_true(all(c("sigma", "mu_kappa", "sigma_kappa", "lp") %in%
                    names(attributes(ret$coef))))
})

