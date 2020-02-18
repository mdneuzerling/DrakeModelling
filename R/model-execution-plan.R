#' drake plan for model execution
#'
#' @return A plan to be run with drake::make()
#' @export
#'
model_execution_plan <- function() {
  plan <- drake::drake_plan(
    import_artefacts(tfidf, vectoriser, review_rf)
  )
}
