context("map-to-dtm")

# Set up a dtm and tfidf based on a small dataset with a predictable outcome

test_reviews <- tibble::tribble(
  ~review,
  "This movie is good fun and everyone should see it. Great film.",
  "What a poor quality phone",
  "This phone has a great battery phone",
  "An excellent piece of software"
)

test_vocabulary <- create_vocabulary(test_reviews$review)
test_vectoriser <- test_vocabulary %>% text2vec::vocab_vectorizer()
test_dtm_unweighted <- map_to_dtm(test_reviews$review,
                                  vectoriser = test_vectoriser,
                                  tfidf = NULL)
test_tfidf <- text2vec::TfIdf$new()
test_tfidf$fit_transform(test_dtm_unweighted)

# The dtms used for testing are below
# Note that "movie" stems to "movi".

dtm_unweighted <- as.matrix(
  map_to_dtm(c("movie", "phone"),
             vectoriser = test_vectoriser,
             tfidf = NULL)
)

dtm_weighted <- as.matrix(
  map_to_dtm(c("movie", "phone"),
             test_vectoriser,
             tfidf = test_tfidf)
)

test_that("DTM has common words that aren't stop words", {
  expect_true("movi" %in% colnames(dtm_unweighted))
  expect_true("phone" %in% colnames(dtm_unweighted))
  expect_true("film" %in% colnames(dtm_unweighted))
})

test_that("DTM doesn't contain common stop words", {
  expect_false("the" %in% colnames(dtm_unweighted))
  expect_false("a" %in% colnames(dtm_unweighted))
})

test_that("DTM correctly represents present and absent words", {
  expect_equal(dtm_unweighted[1, "movi"], 1)
  expect_equal(dtm_unweighted[2, "phone"], 1)
  expect_equal(dtm_unweighted[1, "film"], 0)
  expect_equal(dtm_unweighted[2, "film"], 0)
})

test_that("DTM is applying weightings", {
  expect_true(dtm_weighted[1, "movi"] != 0)
  expect_false(dtm_weighted[1, "movi"] == 1)
  expect_true(dtm_weighted[2, "phone"] != 0)
  expect_false(dtm_weighted[2, "phone"] == 1)
})
