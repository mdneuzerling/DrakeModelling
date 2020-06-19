#' Download and parse review data
#'
#' Given the URL of a .zip file, this function will download it and decompress
#' it to a given location.
#'
#' This function was intended to download and uncompress the data located at
#' https://archive.ics.uci.edu/ml/datasets/Sentiment+Labelled+Sentences
#' It is not a general function to download arbitrary data, but may be a
#' useful template.
#'
#' @param data_source_url Character.
#'
#' @return Tibble of parsed data
#' @importFrom rlang .data
#' @export
#'
download_and_read_data <- function(data_source_url) {
  temp_dir <- tempdir()
  
  zip_file <- file.path(temp_dir, "zip_file")
  on.exit(unlink(zip_file, recursive = TRUE))
  utils::download.file(data_source_url, zip_file)
  data_files <-c("amazon_cells_labelled.txt",
                 "imdb_labelled.txt",
                 "yelp_labelled.txt")
  data_files_in_zip <- file.path("sentiment labelled sentences", data_files)
  utils::unzip(
    zip_file, files = data_files_in_zip, junkpaths = TRUE, exdir = temp_dir
  )
  downloaded_data_files <- file.path(temp_dir, data_files)
  on.exit(unlink(downloaded_data_files), add = TRUE)
  
  downloaded_data_files %>%
    purrr::map(read_review_file) %>%
    purrr::reduce(rbind) %>%
    dplyr::mutate(sentiment = ifelse(.data$sentiment == 1, "good", "bad"))
  
}
