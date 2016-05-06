# only for debugging
context("Test basic Stan models")

test_that("stanmodels exist", {
  expect_true(exists("stanmodels"), "No stanmodels found")
})

test_that("stanmodels$linexp_gastro_1b exists", {
  expect_silent(mod <- stanmodels$linexp_gastro_1b)
  expect_s4_class(mod, "stanmodel")
})

test_that("Direct use of sample model returns valid results", {
  set.seed(471)
  d = simulate_gastempt(n_records = 6)$data
  ret = stan_gastempt(d)
  expect_is(ret, "stan_gastempt")
  # residual standard deviation
  #expect_lt(sqrt(var(ss - s$record$v0)), 7)
})

