#' Assert that model predictions are sensible
#'
#' This function tests that model predictions make sense. It is intended to be
#' run after new data has been scored, but before it has been submitted. We
#' might ensure that outputs are sensible, within an expected range, or do not
#' contain sensitive data. Failed assertions will raise an error. Upon success,
#' the md5 hash of the predictions will be returned.
#'
#' @param predictions A vector of model predictions
#'
#' @return The MD5 hash of the predictions
#' @importFrom assertthat assert_that
#' @export
#'
validate_predictions <- function(predictions) {
  assert_that(all(predictions == "good" | predictions == "bad"))
  
  return(TRUE)
}