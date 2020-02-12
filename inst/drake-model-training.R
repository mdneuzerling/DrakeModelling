plan <- drake::drake_plan(
  reviews = download_and_read_data(),
  vocabulary = create_vocabulary(reviews$review,
                                doc_proportion_min = 25 / nrow(reviews)),
  vectoriser = vocabulary %>% text2vec::vocab_vectorizer(),
  dtm_unweighted = map_to_dtm(reviews$review,
                              vectoriser = vectoriser,
                              tfidf = NULL),
  tfidf = text2vec::TfIdf$new(),
  dtm_tfidf = tfidf$fit_transform(dtm_unweighted),
  review_rf = randomForest::randomForest(
    x = as.matrix(dtm_tfidf),
    y = factor(reviews$sentiment),
    ntree = 500
  )
)
