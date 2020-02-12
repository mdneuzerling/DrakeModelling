#' Create a pruned vocabulary from a token iterator
#'
#' This function creates a vocabulary from a vector of documents. A
#' vocabulary defines the domain of a natural language processing problem.
#' Vocabularies are often used to create vectorisers, which allow novel pieces
#' of text to be mapped to a vocabulary defined by a training set. To exclude
#' frequently and infrequently occurring tokens, the vocabulary is often
#' trimmed. This reduces the dimension of the problem to decrease training time
#' and the potential for overfitting.
#'
#' @param x Character. Text to be processed.
#' @return The same character after processing.
#'
#' @importFrom dplyr %>%
#' @export
#'

text_preprocessor <- function(x) {
  x %>%
    tolower %>%
    tm::removeNumbers() %>%
    tm::removePunctuation()
}
