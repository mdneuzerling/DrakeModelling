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
#' @param documents A vector of characters, often sentences or paragraphs.
#' @param doc_proportion_min Optional. A number between 0 and 1 which specifies
#' the minimum proportion of documents in which a token appears in order to be
#' included in the vocabulary. Defaults to 0 (no effect).
#' @param doc_proportion_max Optional. A number between 0 and 1 which specifies
#' the maximum proportion of documents in which a token appears in order to be
#' included in the vocabulary. Defaults to 1 (no effect).
#' @return A vocabulary object used in the text2vec package
#'
#' @export
#'
create_vocabulary <- function(documents,
                              doc_proportion_min = 0,
                              doc_proportion_max = 1) {
  # For some reason, the preprocessor and stem_tokeniser don't take effect if
  # I put them in the itoken function as values to the relevant arguments.
  # Please let me know if you understand why this is!
  processed_documents <- stem_tokeniser(text_preprocessor(documents))

  # Warning: token iterators can only be used once.
  token_iterator <- text2vec::itoken(
    processed_documents,
    progressbar = FALSE
  )

  vocabulary <- text2vec::create_vocabulary(
    token_iterator,
    stopwords = tidytext::stop_words$word
  )

  vocabulary <- text2vec::prune_vocabulary(
    vocabulary,
    doc_proportion_min = doc_proportion_min,
    doc_proportion_max = doc_proportion_max
  )

  return(vocabulary)
}
