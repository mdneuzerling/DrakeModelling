#' Classify a review as good or bad
#'
#' @param x Text to be classified, ideally a one-sentence product review.
#' @param random_forest A model created with the randomForest package.
#'
#' @importFrom randomForest randomForest
#' @export
#'
sentiment <- function(x, random_forest, vectoriser) {
  processed <- map_to_dtm(x, vectoriser = vectoriser)
  as.character(stats::predict(random_forest, processed))
}
