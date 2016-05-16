context("Test nlme fit to gastric emptying data")
test_nlme = TRUE

# only for debugging
if (FALSE) {
  library(testthat)
  library(ggplot2)
  library(assertthat)
  library(nlme)
  library(dplyr)
}

test_that("nlme_gastempt returns a valid structure", {
  skip_if_not(test_nlme)
  set.seed(4711)
  d = simulate_gastempt()$data
  fit = nlme_gastempt(d)
  expect_is(fit, "nlme_gastempt")
  expect_equal(fit$message, "Ok")
  expect_equal(names(fit), c("coef", "summary", "plot", "pnlsTol","message"))
  expect_is(plot(fit), "ggplot")
  expect_is(coef(fit), "data.frame")
  expect_equal(as.numeric(coef(fit, signif = 1)[1,2]) , 500)
})

test_that("nlme_gastempt can handle noisy and missing data", {
  skip_if_not(test_nlme)
  set.seed(11)
  d = simulate_gastempt(kappa_mean=1, noise = 40, student_t_df = 3)$data
  fit = nlme_gastempt(d)
  expect_equal(fit$message, "Ok")
  set.seed(12)
  # many missing
  d = simulate_gastempt(kappa_mean = 1, noise = 30, missing = 0.40,
                        student_t_df = 5)$data
  fit = nlme_gastempt(d)
  expect_equal(fit$message, "Ok")
})



test_that("nlme_gastempt with special data fails", {
  skip_if_not(test_nlme)
  # This fails
  set.seed(1706)
  d = simulate_gastempt()$data
  fit = nlme_gastempt(d, model = linexp)
  expect_equal(fit$pnlsTol, 0.625)

  # Try pdDiag works
  fit = nlme_gastempt(d, variant = 2)
  expect_equal(fit$pnlsTol, 0.001)

  # Try constant beta
  fit = nlme_gastempt(d, variant = 3)
  expect_equal(fit$pnlsTol, 0.001)
})


search_pnlsTol = function(model = linexp, nlme_model = linexp,
                          variant = 1){
  # Only used manually to find interesting start values for test design
  set.seed(4711)
  while (TRUE) {
    r = sample.int(10000,1)
    set.seed(r)
    d = simulate_gastempt(model = model)$data
    fit = nlme_gastempt(d, model = nlme_model, variant = variant)
    cat(r, " ",fit$pnlsTol, fit$summary$numIter, "\n")
  }
}

#search_pnlsTol()
#search_pnlsTol(model = powexp, nlme_model = linexp)

test_that("fit of powexp data to powexp curve gives valid coefficients", {
  skip_if_not(test_nlme)
  set.seed(4711)
  d = simulate_gastempt(model = powexp)$data
  expect_match(comment(d), "beta")
  fit = nlme_gastempt(d, model = powexp)
  expect_equal(fit$pnlsTol, 0.001)
  expect_is(fit, "nlme_gastempt")
  expect_equal(fit$message, "Ok")
  expect_equal(names(fit), c("coef", "summary", "plot", "pnlsTol","message"))
  expect_is(plot(fit), "ggplot")
  expect_is(coef(fit), "data.frame")
  fit = nlme_gastempt(d, model = powexp, variant = 2)
  expect_equal(fit$pnlsTol, 0.001)
  fit = nlme_gastempt(d, model = powexp, variant = 3)
  expect_equal(fit$pnlsTol, 0.001)
})


test_that("fit of default powexp data to linexp curve fails often", {
  skip_if_not(test_nlme)
  set.seed(9344)
  d = simulate_gastempt(model = powexp)$data
  fit = nlme_gastempt(d, model = linexp)
  expect_match(fit$message, "pnlsTol")
  # variant 2 fails
  fit = nlme_gastempt(d, model = linexp, variant = 2)
  expect_match(fit$message, "pnlsTol")
  # variant 3 fails
  fit = nlme_gastempt(d, model = linexp, variant = 3)
  expect_match(fit$message, "pnlsTol")
})

test_that("fit of powexp data with beta=2 to linexp curve converges", {
  skip_if_not(test_nlme)
  set.seed(4711)
  d = simulate_gastempt(beta_mean = 2,model = powexp)$data
  fit = nlme_gastempt(d, model = linexp)
  expect_equal(fit$pnlsTol, 0.001)
  expect_equal(fit$message, "Ok")
  fit = nlme_gastempt(d, model = linexp)
})


