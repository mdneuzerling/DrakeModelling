#' Export a model artefact to inst/artefacts
#'
#' A model artefact could be a model itself, or an object used in preprocessing
#' (like a recipe). This function saves artefacts to the inst/artefacts 
#' directory of the package, but it could just as easily export to a remote
#' resource like cloud storage.
#'
#' @param artefact Object that will be exported as an RDS
#' @param name File name to use, without the directory. If not provided, will
#' attempt to save as "artefact.rds", although this will fail for piped objects.
#'
#' @return Returns the artefact, invisibly.readr:
#' @export
#'
export_artefact <- function(artefact, name = NULL) {
  if (is.null(name)) {
    name = deparse(substitute(artefact))
    if (name == ".") {
      stop("Please provide a name for the exported artefact")
    }
    name = paste0(name, ".rds")
  }
  
  artefact_dir <- file.path(here::here(), "inst", "artefacts")
  dir.create(artefact_dir, showWarnings = FALSE)
  
  save_location <- file.path(artefact_dir, name)
  message("Writing artefact to ", save_location)
  
  readr::write_rds(artefact, save_location)
  
  invisible(artefact)
}
