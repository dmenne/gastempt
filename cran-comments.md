## Test environments

-   local R installation, R 4.0.4
-   github actions (Windows, Mac, Ubuntu)
-   Testing on travis-CI discontinued

## gastempt Version 0.5.4

-   Made examples \donttest (were: dontrun). Even a reduced tests runs 30 seconds on CRAN.

-   `par` reset to default in fitfuncs.R

-   Renamed `fitfuncs.r`to \`fitfuncs.R\`

-   Explicitly named fields `email` and `role` in DESCRIPTION. I do not understand what is meant with "e.g.: Trustees of Columbia University" in the CRAN review. I am the sole package author/contributor.

-   "Have the issues why your package was archived been fixed?" I still do not understand why the package was archived because it failed on Windows 32 bit with incomprehensible messages. I assume it has to do with the ever-changing `Rcpp` makevars settings for `rstan`. All settings were re-generated with presets of Stan in Feb 2021. One test set crashes on aarch64 and is skipped now on CRAN.
