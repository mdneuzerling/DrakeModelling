#' drake plan for model execution
#'
#' @return A plan to be run with drake::make()
#' @export
#'
model_execution_plan <- function() {
  drake::drake_plan(
    new_data = new_data_to_be_scored(),
    tfidf = import_artefact("tfidf.rds"),
    vectoriser = import_artefact("vectoriser.rds"),
    review_rf = import_artefact("review_rf.rds"),
    predictions = sentiment(new_data$review,
                            random_forest = review_rf,
                            vectoriser = vectoriser,
                            tfidf = tfidf),
    validation_hash = validate_predictions(predictions),
    submit_predictions = target(submit_predictions(predictions),
                                trigger = trigger(change = validation_hash))
  )
}
