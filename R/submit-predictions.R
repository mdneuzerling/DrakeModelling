#' Simulate submission of output data
#'
#' This is a dummy function that simulates the submission of newly scored 
#' model results to an external platform. In actual fact, this function does
#' nothing, but sleeps for 5 seconds to simulate an upload process.
#'
#' @param predictions Predictions to be submitted. Format is not important. 
#'
#' @return Returns output, invisibly
#' @export
#'
submit_predictions <- function(predictions) {
  Sys.sleep(5)
  invisible(predictions)
}