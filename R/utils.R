#' @inherit magrittr::'%>%'
#' @export
`%>%` <- magrittr::'%>%'

#' @export
`+.key` <- function (e1, e2)
{
  sprintf('%s+%s',e1,e2)
}
