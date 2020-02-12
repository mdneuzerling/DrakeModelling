#' Download and read review data
#'
#' @param save_location character. The contents of the downloaded zip file will
#' be uncompressed and saved here. If save_location does not exist, it will be
#' created, as well as any missing parent directories.
#'
#' @return Tibble of parsed data
#' @export
#'
download_and_read_data <- function(save_location = NULL) {

  if (is.null(save_location)) {
    save_location <- tempdir()
    on.exit(unlink(save_location))
  }

  dir.create(save_location, showWarnings = FALSE)
  
  data_files <- file.path(save_location, data_files())
  
  if (any(!file.exists(data_files))) {
    download_data(save_location = save_location)
  }

  data_files %>% 
    purrr::map(read_review_file) %>%
    purrr::reduce(rbind) %>% 
    dplyr::mutate(sentiment = ifelse(sentiment == 1, "good", "bad"))
  
}