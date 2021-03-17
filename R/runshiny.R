#' Run shiny app demonstrating fit strategies with simulated data
#'
#' @return  Not used, starts shiny app
#' @export
#'
run_shiny = function() {
  app_dir = system.file("shiny", package = "gastempt")
  if (app_dir == "") {
    stop("Could not Shiny app in gastempt", call. = FALSE)
  }
  shiny::runApp(app_dir, display.mode = "normal")
}
