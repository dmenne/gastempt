#' Fit gastric emptying curves with Stan
#'
#' @param d A data frame with columns
#' \itemize{
#'   \item \code{rec} Record descriptor as grouping variable, e.g. patient ID
#'   \item \code{minute} Time after meal or start of recording.
#'   \item \code{vol} Volume of meal or stomach
#'  }
#' @param model_name Name of predefined model in
#' \code{gastempt/exec}. Use \code{stan_model_names()} to get a list
#' of available models.
#' @param lkj LKJ prior for kappa/tempt correlation, only required
#' for model linexp_gastro_2b. Values from 1.5 (strong correlation) to 50
#' (almost independent) are useful. See
#' \url{http://www.psychstatistics.com/2014/12/27/d-lkj-priors/} for examples.
#' @param student_df Student-t degrees of freedom for residual error;
#' default 5. Use 3 for strong outliers; values above 10 are close to gaussian
#' residual distribution.
#' @param init for stan; default = 0. When you plan to use random
#' initialization, check chains carefully, they often get stuck.
#' @param chains for stan; default = 4. For debugging, use 1.
#' @param ... Additional parameter passed to \code{sampling}
#'
#' @return A list of class stan_gastempt with elements \code{coef, fit, plot}
#' \itemize{
#'   \item \code{coef} is a data frame with columns:
#'     \itemize{
#'       \item \code{rec} Record descriptor, e.g. patient ID
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
#' @examples
#'   dd = simulate_gastempt(n_records = 6, seed = 471)
#'   d = dd$data
#'   ret = stan_gastempt(d)
#'   print(ret$coef)
#' @import rstan
#' @importFrom utils capture.output
#' @export
stan_gastempt = function(d, model_name = "linexp_gastro_2b", lkj = 2,
                         student_df = 5L, init = 0, chains = 4,  ...){
  assert_that(all(c("record", "minute","vol") %in% names(d)))
#  rstan_options(auto_write = TRUE)
#  options(mc.cores = parallel::detectCores())
  # Integer index of records
  d$record_i =  as.integer(as.factor(d$record))

  data = list(
    prior_v0 = median(d$vol[d$minute < 10]), # only required for _1x
    n = nrow(d),
    n_record = max(d$record_i),
    lkj = lkj,
    student_df = as.integer(student_df),
    record = d$record_i,
    minute = d$minute,
    volume = d$vol)
  mod = stanmodels[[model_name]]
  testthat::expect_s4_class(mod, "stanmodel")
  capture.output({
    #fit = suppressWarnings(sampling(mod, data = data))
    fit = suppressWarnings(sampling(mod, data = data, init = init,
                                    chains = chains, ...))
  })
  cf = summary(fit)$summary[,1]
  coef = data_frame(
    record = unique(d$record),
    v0 = cf[grep("v0\\[", names(cf))],
    kappa = cf[grep("^kappa", names(cf))],
    tempt = cf[grep("^tempt", names(cf))]
  ) %>% t50
  attr(coef, "sigma") = cf["sigma"]
  attr(coef, "mu_kappa") = cf["mu_kappa"]
  attr(coef, "sigma_kappa") = cf["sigma_kappa"]
  attr(coef, "lp") = cf["lp__"]
  #
  # Compute plot
  plot = ggplot(d, aes(x = minute, y = vol)) + geom_point() +
    facet_wrap(~ record) +
    expand_limits(x = 0, y = 0) # force zeroes to be visible
  minute = seq(min(d$minute), max(d$minute), length.out = 51)
  if (grep("linexp", model_name)){
    title = paste0("Stan fitted linexp function, model ", model_name)
    pred_func = linexp
  } else {
    ### TODO Not tested
    title = paste0("Fitted powexp function, model ", model_name)
    pred_func = powexp
  }
  newdata  = coef %>%
    rowwise() %>%
    do({
      # TODO: powexp
      vol = pred_func(minute, v0 = .$v0, tempt = .$tempt, kappa = .$kappa )
      data_frame(record = .$record, minute = minute, vol = vol)
    })

  plot = plot + geom_line(data = newdata, col = "#006400")  +
    ggtitle(title, subtitle = comment(d))

  # Assemble return
  ret = list(coef = coef, fit = fit, plot = plot)
  class(ret) = "stan_gastempt"
  ret
}


if (FALSE) {
  library(gastempt)
  library(rstan)
  library(dplyr)
  library(assertthat)
  dd = simulate_gastempt(n_records = 6, seed = 471)
  d = dd$data
  ret = stan_gastempt(d)
  coef = ret$coef
  plot(ret$plot)
}
