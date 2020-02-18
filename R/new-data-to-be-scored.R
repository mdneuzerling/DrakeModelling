#' Retrieve new data that needs to be scored
#'
#' This function is meant to replicate a function that will retrieve new data
#' that needs to be scored. This is a batch execution, rather than an on-demand
#' API that might be stood up by the plumber package. In practice, the return
#' is a fixed sample of 10 reviews.
#'
#' @return Data frame with two char columns: review and sentiment ("good"/"bad")
#' @export
#'
#' @examples
new_data_to_be_scored <- function() {
  tribble(
    ~"review", ~"sentiment",
    "I'm still infatuated with this phone.", "good",
    "Strike 2, who wants to be rushed.", "bad",
    "I enjoyed reading this book to my children when they were little.", "good",
    "We had a group of 70+ when we claimed we would only have 40 and they handled us beautifully.", "good",
    "The story is lame, not interesting and NEVER really explains the sinister origins of the puppets", "bad",
    "Better than you'd expect.", "good",
    "It was a huge awkward 1.5lb piece of cow that was 3/4ths gristle and fat.", "bad",
    "Yes, it's that bad.", "bad",
    "I did not expect this to be so good!", "good",
    "The only redeeming quality of the restaurant was that it was very inexpensive.", "good"
  )
}