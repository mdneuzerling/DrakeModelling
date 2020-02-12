#' Download and uncompress review data
#'
#' Given the URL of a .zip file, this function will download it and decompress
#' it to a given location.
#'
#' This function was intended to download and uncompress the data located at
#' https://archive.ics.uci.edu/ml/datasets/Sentiment+Labelled+Sentences
#' It is not a general function to download arbitrary data, but may be a
#' useful template.
#'
#' @param save_location character. The contents of the downloaded zip file will
#' be uncompressed and saved here. If save_location does not exist, it will be
#' created, as well as any missing parent directories.
#'
#' @export
#'
download_data <- function(save_location = getwd()) {
  data_source_url <- paste0("https://archive.ics.uci.edu",
                            "/ml/machine-learning-databases/00331",
                            "/sentiment%20labelled%20sentences.zip")

  zip_file <- tempfile()
  on.exit(unlink(zip_file))
  utils::download.file(data_source_url, zip_file)

  dir.create(save_location, showWarnings = FALSE, recursive = TRUE)

  data_files <- file.path("sentiment labelled sentences", data_files())

  utils::unzip(zip_file, files = data_files, junkpaths = TRUE, exdir = save_location)
}
