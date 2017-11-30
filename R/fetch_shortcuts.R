#' @title Current Addins
#' @description Retrieve current Addins and if they have shortcuts they are defined.
#' @return data.frame
#' @rdname fetch_shortcuts
#' @export
fetch_shortcuts <- function(){

  installed_addins <- fetch_addins(keep_libpath = TRUE)

  return(installed_addins)

}
