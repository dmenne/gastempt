.onLoad <- function(libname, pkgname) {
  Rcpp::loadModule("stan_fit4linexp_gastro_1b_mod")
}
