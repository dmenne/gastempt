.onLoad <- function(libname, pkgname) {
  Rcpp::loadModule("stan_fit4linexp_gastro_1b_mod", TRUE)
  Rcpp::loadModule("stan_fit4linexp_gastro_1c_mod", TRUE)
  Rcpp::loadModule("stan_fit4linexp_gastro_1d_mod", TRUE)
  Rcpp::loadModule("stan_fit4linexp_gastro_2b_mod", TRUE)
  Rcpp::loadModule("stan_fit4linexp_gastro_2c_mod", TRUE)
  Rcpp::loadModule("stan_fit4powexp_gastro_2c_mod", TRUE)
}
