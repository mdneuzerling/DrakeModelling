#' Read a review source data file into a data frame
#'
#' This function is specifically intended to parse the three data files in the
#' sentiment analysis data set
#' (https://archive.ics.uci.edu/ml/datasets/Sentiment+Labelled+Sentences).
#'
#' @param file_path character. A file path to a source .txt data file
#'
#' @export
#'
read_review_file <- function(file_path) {
  readr::read_tsv(
    file_path,
    col_names = c("review", "sentiment"),
    quote = "",
    col_types = readr::cols(
      review = readr::col_character(),
      sentiment = readr::col_integer()
    )
  )
}
