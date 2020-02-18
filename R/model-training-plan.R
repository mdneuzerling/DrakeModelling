#' drake plan for model training
#'
#' @return A plan to be run with drake::make()
#' @importFrom drake trigger
#' @export
#'
model_training_plan <- function() {
  drake::drake_plan(
    reviews = download_and_read_data(),
    vocabulary = create_vocabulary(reviews$review,
                                   doc_proportion_min = 25 / nrow(reviews)),
    vectoriser = text2vec::vocab_vectorizer(vocabulary),
    dtm_unweighted = map_to_dtm(reviews$review,
                                vectoriser = vectoriser),
    tfidf = create_tfidf(dtm_unweighted),
    dtm_tfidf_weighted = map_to_dtm(reviews$review,
                                    vectoriser = vectoriser,
                                    tfidf = tfidf),
    review_rf = randomForest::randomForest(
      x = as.matrix(dtm_tfidf_weighted),
      y = factor(reviews$sentiment),
      ntree = 500
    ),
    validation_hash = validate_model(review_rf, vectoriser, tfidf),
    export_tfidf = target(export_artefact(tfidf),
                          trigger = trigger(change = validation_hash)),
    export_vectoriser = target(export_artefact(vectoriser),
                               trigger = trigger(change = validation_hash)),
    export_model = target(export_artefact(review_rf),
                             trigger = trigger(change = validation_hash))
  )
}
