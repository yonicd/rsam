#' @title Current Addins shortcuts
#' @description Retrieve current defined Addin shortcuts
#' @return data.frame
#' @seealso
#'  \code{\link[jsonlite]{fromJSON}}
#' @rdname fetch_addin_keys
#' @export
#' @importFrom jsonlite fromJSON
fetch_addin_keys <- function(){

  if(!file.exists("~/.R/rstudio/keybindings/addins.json"))
    return(NULL)

  json_now <- jsonlite::fromJSON("~/.R/rstudio/keybindings/addins.json")

  current_keys <- unlist(json_now)

  current_names <- names(current_keys)

  current_keys <- data.frame(Package=gsub('::(.*?)$','',current_names),
                             Binding=gsub('^(.*?)::','',current_names),
                             Shortcut=current_keys,
                             stringsAsFactors = FALSE,
                             row.names = NULL)

  current_keys$Shortcut[!nzchar(current_keys$Shortcut)] <- NA

  current_keys$Key <- paste(current_keys$Package,current_keys$Binding,sep = '::')

  return(current_keys)

}
