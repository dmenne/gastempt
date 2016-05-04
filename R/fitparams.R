#' Compute half-emptying time from nlme parameters
#'
#' No closed solution known for linexp, we use newton  approximation
#' @name t50
#' @param x  Result of a nlme fit, with named components `tempt, beta, logbeta,
#' kappa, logkappa` depending on model. Function used `logbeta` when it is present,
#' in `x`, otherwise beta, and similar for logkappa/kappa.
#' @return Half-emptying time. Name of evaluated function is returned as attribute \code{fun}. Negative of slope is returned as attribute \code{slope}.
#' @export
t50 = function(x) {
  UseMethod("t50", x)
}

#' @export
t50.default = function(x){
  tempt = ifelse("logtempt" %in% names(x), exp(x["logtempt"]), x["tempt"])
  # Search interval is 5*tempt
  interval = c(.0001, 5*tempt)
  v0 = ifelse(is.na(x["v0"]), 1, x["v0"])
  if ("logbeta" %in% names(x)) {
    ssfun = powexp_log
    ret = uniroot(function(t)
      powexp_log(t, 1, x["logtempt"], x["logbeta"]) - 0.5,
      interval = interval)$root
    slope = powexp_slope(ret, v0, exp(x["logtempt"]), exp(x["logbeta"]))
  } else if ( "beta" %in% names(x)) {
      ssfun = powexp
      ret = uniroot(function(t)
        powexp(t, 1, x["tempt"], x["beta"] ) - 0.5,
        interval = interval)$root
        slope = powexp_slope(ret, v0, x["tempt"], x["beta"])
    } else
      if ("logkappa" %in% names(x)) {
        ssfun = linexp_log
        ret = uniroot(function(t)
          linexp_log(t, 1, x["logtempt"], x["logkappa"]) - 0.5,
          interval = interval)$root
          slope = linexp_slope(ret, v0, exp(x["logtempt"]), exp(x["logkappa"]))
      } else
        if ("kappa" %in% names(x)) {
          ssfun = linexp
          ret = uniroot(function(t)
            linexp(t, 1, x["tempt"], x["kappa"]) - 0.5,
            interval = interval)$root
            slope = linexp_slope(ret, v0, x["tempt"], x["kappa"])
        }
  attr(ret, "slope") = -as.numeric(slope)
  attr(ret, "fun" ) = ssfun
  ret
}

#' @export
t50.data.frame = function(x){
  assert_that(all(c("record","tempt","v0") %in% names(x)))
  x$t50 = 0
  x$slope_t50 = 0
  for (i in 1:nrow(x)) {
    tt =  t50(unlist(x[i,-1]))
    x[i,"t50"] = as.numeric(tt)
    x[i,"slope_t50"] = attr(tt,"slope")
  }
  x
}

