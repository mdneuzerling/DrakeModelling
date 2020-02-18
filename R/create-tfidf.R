#' Create a fitted tf-idf
#'
#' The text2vec package uses a Pythonic style of code to create a fitted term
#' frequency - inverse document frequency (tf-idf) object. A new tfidf object
#' is initialised and then the tfidf$fit_transform method is applied to an
#' unweighted document-term matrix. This style of code is unusual in R and
#' can cause issues with drake. This function creates a fitted tfidf object
#' with a more functional and R-idiomatic style of code.
#'
#' @param dtm_unweighted An unweighted document term matrix created by the
#' map_to_dtm function, or an equivalent from text2vec.
#'
#' @return A fitted tfidf objet created by the text2vec package
#' @export
#'
create_tfidf <- function(dtm_unweighted) {
  tfidf = text2vec::TfIdf$new()
  tfidf$fit_transform(dtm_unweighted)
  return(tfidf)
}