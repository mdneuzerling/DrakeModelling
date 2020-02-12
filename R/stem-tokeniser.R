#' Stem and tokenise a sentence
#'
#' @param x A character or vector of characters, usually sentences, paragraphs
#' or similar pieces of natural language.
#' @return A vector of tokens
#'
#' @export
#'
#' @examples stem_tokeniser("information informed informing informs")
#'
stem_tokeniser <- function(x) {
  lapply(
    text2vec::word_tokenizer(x),
    SnowballC::wordStem,
    language = "en"
  )
}
