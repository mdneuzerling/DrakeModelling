#' drake plan for model execution
#'
#' @return A plan to be run with drake::make()
#' @export
#'
model_execution_plan <- function() {
  drake::drake_plan(
    new_data = new_data_to_be_scored(),
    tfidf = readr::read_rds(file_in("artefacts/tfidf.rds")),
    vectoriser = readr::read_rds(file_in("artefacts/vectoriser.rds")),
    review_rf = readr::read_rds(file_in("artefacts/review_rf.rds")),
    predictions = sentiment(new_data$review,
                            random_forest = review_rf,
                            vectoriser = vectoriser,
                            tfidf = tfidf),
    validation = validate_predictions(predictions),
    submit_predictions = target(
      submit_predictions(predictions),
      trigger = trigger(condition = validation, mode = "blacklist")
    )
  )
}
