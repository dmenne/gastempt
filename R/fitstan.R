#' Fit gastric emptying curves with Stan
#'
#' @param d A data frame with columns
#' \itemize{
#'   \item \code{record} Record descriptor as grouping variable, e.g. patient ID
#'   \item \code{minute} Time after meal or start of recording.
#'   \item \code{vol} Volume of meal or stomach
#'  }
#'
#' @return A list of class stan_gastempt with elements \code{coef, fit, plot}
#' \itemize{
#'   \item \code{coef} is a data frame with columns:
#'     \itemize{
#'       \item \code{record} Record descriptor, e.g. patient ID
#'       \item \code{v0} Initial volume at t=0
#'       \item \code{tempt} Emptying time constant
#'       \item \code{kappa} Parameter \code{kappa} for
#'             \code{model = linexp}
#'       \item \code{beta} Parameter \code{beta} for \code{model = powexp}
#'       \item \code{t50} Half-time of emptying
#'       \item \code{slope_t50} Slope in t50; typically in units of ml/minute
#'  On error, coef is NULL
#'    }
#'   \item \code{fit} Result of class `stanfit`
#'   \item \code{plot} A ggplot graph of data and prediction. Plot of raw data is
#'      returned even when convergence was not achieved.
#'  }
#' @useDynLib gastempt, .registration = TRUE
#' @import rstan
#' @export
stan_gastempt = function(d){
  assert_that(all(c("record", "minute","vol") %in% names(d)))
#  rstan_options(auto_write = TRUE)
#  options(mc.cores = parallel::detectCores())
  # Integer index of records
  d$record_i =  as.integer(as.factor(d$record))

  data = list(
    prior_v0 = median(d$vol[d$minute < 10]),
    n = nrow(d),
    n_record = max(d$record_i),
    record = d$record_i,
    minute = d$minute,
    volume = d$vol)
  mod = stanmodels$linexp_gastro_1b
  testthat::expect_s4_class(mod, "stanmodel")
  testthat::expect_identical(mod@model_name, "linexp_gastro_1b")
  fit = sampling(mod, data = data, chain = 2, iter = 1000)
  coef = summary(fit)$summary[,1]
  ret = list(coef = coef, fit = fit, plot = NULL)
  class(ret) = "stan_gastempt"
  ret
}
