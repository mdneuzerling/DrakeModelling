context("test-text-preprocessor")

test_that("Case is lowered", {
  test_string <- "SPHYNX OF BLACK QUARTZ judge my VoW"
  expected_result <- "sphynx of black quartz judge my vow"
  expect_equal(text_preprocessor(test_string), expected_result)
})

test_that("Punctuation is removed", {
    test_string <- "\"sphynx. of black quartz, judge - my vow!\""
    expected_result <- "sphynx of black quartz judge  my vow"
    expect_equal(text_preprocessor(test_string), expected_result)
})

test_that("Numbers are removed", {
    test_string <- "\"sphynx. o10f black qu1artz, ju2dge - my vow!\""
    expected_result <- "sphynx of black quartz judge  my vow"
    expect_equal(text_preprocessor(test_string), expected_result)
})

test_that("Case is lowered, punctuation and numbers are removed", {
    test_string <- "\"SPHYNX. o10f bLaCk qu1artz, ju2dge - my vow!\""
    expected_result <- "sphynx of black quartz judge  my vow"
    expect_equal(text_preprocessor(test_string), expected_result)
})

test_that("Processing vector of text", {
  test_strings <- c("fish", "KING!", "cA4rD")
  expected_result <- c("fish", "king", "card")
  expect_equal(text_preprocessor(test_strings), expected_result)
})
