#' Create a document term matrix using a vectoriser
#'
#' This function uses a vectoriser created with the text2vec package to map
#' a new piece of text, or vector of text, onto a document term matrix (dtm).
#' The vectoriser has a concept of a vocabulary, a set of tokens which
#' determine the columns of the resulting document term matrix. Any term that
#' doesn't match to a token in the vocabulary will be ignored. Optionally, the
#' document term matrix can be weighted by a term frequency-inverse document
#' frequency (tfidf) object, created with the text2vec::TfIdf function.
#'
#' @param x A character or vector of characters, usually sentences, paragraphs
#' or similar pieces of natural language.
#' @param vectoriser A vectoriser constructed with the text2vec package.
#' @param tfidf A tfidf object constructed with the text2vec package.
#' If no tfidf is NULL, then an unweighted document term matrix will be
#' returned.
#' @return A document-term matrix with rows representing the textual objects in
#' x, and columns representing the tokens in the vocabulary used to generate the
#' given vectoriser.
#'
#' @export
#'
map_to_dtm <- function(x,
                       vectoriser,
                       tfidf = NULL) {
  processed_text <- stem_tokeniser(text_preprocessor(x))

  # For some reason, the preprocessor and stem_tokeniser don't take effect if
  # I put them in the itoken function as values to the relevant arguments.
  # Please let me know if you understand why this is!
  tokens <- text2vec::itoken(
    processed_text,
    progressbar = FALSE
  )

  # If the input contains no terms corresponding the to vocabulary used to
  # generate the vectoriser, then a warning will occur for an empty dtm.
  # Since this is a plausible scenario, we suppress the warning.
  suppressWarnings(
    dtm <- text2vec::create_dtm(tokens, vectoriser)
  )

  if (!is.null(tfidf)) {
    dtm <- tfidf$transform(dtm)
  }

  return(dtm)
}
