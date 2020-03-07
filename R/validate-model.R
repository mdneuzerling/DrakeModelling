#' Assert that model makes sensible predictions
#'
#' This function tests model predictions against a small sample of inputs with
#' predictable outputs. For example, a sentiment analysis model that returns
#' a sentiment of "bad" for "love" should not be used. We can also demand a
#' minimum level of accuracy according to one or more metrics. Any failed 
#' assertions will raise an error. This validation approach could also be used
#' to perform rudimentary checks for model bias (in the ethics sense).
#'
#' @param random_forest A model created with the randomForest package.
#' @param vectoriser A vectoriser constructed with the text2vec package.
#' @param tfidf A tfidf object constructed with the text2vec package.
#' If no tfidf is NULL, then weighting will not be applied.
#'
#' @return The MD5 hash of the random_forest object
#' @importFrom assertthat assert_that
#' @export
#'
validate_model <- function(random_forest, vectoriser, tfidf = NULL) {
  model_sentiment <- function(x) sentiment(x, random_forest, vectoriser, tfidf)
  oob <- random_forest$err.rate[random_forest$ntree, "OOB"]

  assert_that(model_sentiment("love") == "good")
  assert_that(model_sentiment("bad") == "bad")
  assert_that(oob < 0.4)

  return(TRUE)
}