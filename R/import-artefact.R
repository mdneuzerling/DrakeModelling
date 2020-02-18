#' Import a model artefact from inst/artefacts
#'
#' A model artefact could be a model itself, or an object used in preprocessing
#' (like a recipe). This function reads artefacts from the inst/artefacts 
#' directory of the package, but it could just as easily import from a remote
#' resource like cloud storage.
#'
#' @param artefact_name RDS object that will be imported
#'
#' @return The object parsed by readr
#' @export
#'
import_artefact <- function(artefact_name) {
  if (artefact_name == ".") {
    stop("Please provide a name for the imported artefact")
  }
  artefact_dir <- file.path(here::here(), "inst", "artefacts")
  artefact_path <- file.path(artefact_dir, artefact_name)
  readr::read_rds(artefact_path)
}