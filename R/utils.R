#' @inherit magrittr::'%>%'
#' @export
`%>%` <- magrittr::'%>%'

#' @export
`+.key` <- function (e1, e2)
{
  sprintf('%s+%s',e1,e2)
}

#' @importFrom utils menu
yesno <- function(...) {
  yeses <- c("Yes", "Definitely", "For sure", "Yup", "Yeah", "I agree", "Absolutely")
  nos <- c("No way", "Not yet", "I forget", "No", "Nope", "Uhhhh... Maybe?")

  cat(paste0(..., collapse = ""))
  qs <- c(sample(yeses, 1), sample(nos, 2))
  rand <- sample(length(qs))

  utils::menu(qs[rand]) != which(rand == 1)
}
