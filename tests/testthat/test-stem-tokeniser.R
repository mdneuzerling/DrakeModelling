context("stem-tokeniser")

test_that("Processing inflections of the same stem", {
  expect_equal(
    stem_tokeniser("information informed informing informs"),
    list(c("inform", "inform", "inform", "inform"))
  )
})

test_that("Stemming multiple documents", {
  expect_equal(
    stem_tokeniser(c("information", "product")),
    list("inform", "product")
  )
})
