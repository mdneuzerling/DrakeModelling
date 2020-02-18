#' Classify a review as good or bad
#'
#' @param x Text to be classified, ideally a one-sentence product review.
#' @param random_forest A model created with the randomForest package.
#' @param vectoriser A vectoriser constructed with the text2vec package.
#' @param tfidf A tfidf object constructed with the text2vec package.
#' If no tfidf is NULL, then weighting will not be applied.
#'
#' @importFrom randomForest randomForest
#' @export
#'
sentiment <- function(x, random_forest, vectoriser, tfidf = NULL) {
  processed <- map_to_dtm(x, vectoriser = vectoriser, tfidf = tfidf)
  as.character(stats::predict(random_forest, processed))
}
