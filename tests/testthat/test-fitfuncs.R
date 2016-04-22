context("Test fit functions")
tolerance = 5.e-5


test_that("Functions at t=0 must return initial volume",{
  v0 = 400
  tempt = 60
  kappa = 2
  t = c(0, 10, 300)
  # linexp
  r = linexp(t, v0, tempt, kappa)
  expect_equal(r[1], v0)
  expect_gt(r[2], r[1])
  expect_lt(r[3], r[1])

  rlog = linexp_log(t, v0, log(tempt), log(kappa))
  expect_equal(rlog[1], v0)
  expect_gt(rlog[2], rlog[1])
  expect_lt(rlog[3], rlog[1])

  expect_equal(r, rlog)

  # Power exponential
  beta = 2
  r = powexp(t, v0, tempt, beta)
  expect_equal(r[1], v0)
  expect_lt(r[2], r[1])
  expect_lt(r[3], r[1])

  rlog = powexp_log(t, v0, log(tempt), log(beta))
  expect_equal(rlog[1], v0)
  expect_lt(rlog[2], r[1])
  expect_lt(rlog[3], r[1])

  expect_equal(r, rlog)

})

test_that("Limiting cases of slopes are correct",{
  tempt = 60
  kappa = 1
  # linexp
  t = c(0, 10, 300)
  r = linexp_slope(t, tempt = tempt, kappa = 1)
  expect_equal(r[1], 0)
  expect_lt(r[2], 0)
  expect_lt(r[3], 0)
  r = linexp_slope(0, tempt = tempt, kappa = 0)*tempt
  expect_equal(r, -1)

  r = powexp_slope(0, tempt = tempt, beta = 1)
  expect_true(is.nan(r))
  r = powexp_slope(1e-5, tempt = tempt, beta = 1)*tempt
  expect_equal(r, -1, tolerance = tolerance)
})


