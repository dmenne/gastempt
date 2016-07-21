#' @export
run_shiny <- function() {
  appDir <- system.file("shiny", package = "gastempt")
  if (appDir == "") {
    stop("Could not Shiny app in gastempt", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")
}