.onLoad <- function(libname, pkgname) {
#  if (!("methods" %in% .packages())) attachNamespace("methods")
#  message(libname, " ", pkgname)
  Rcpp::loadRcppModules()
}
