#' @title Current Addins
#' @description Retrieve current installed Addins
#' @param fields character, fields to return from output data.frame, NULL returns all,
#'   Default: NULL
#' @return data.frame containing the columns: c('Package', 'Name', 'Description',
#'   'Binding', 'Interactive', 'libpath', 'Key', 'Shortcut')
#' @rdname fetch_addins
#' @export
#' @importFrom utils installed.packages
fetch_addins <- function(fields=NULL){

  addin_pkgs <- anti_addin()

  addins <- lapply(addin_pkgs,function(x){
    ret <- read.dcf(x)
    s <- strsplit(x,'/')[[1]]
    s <- s[length(s)-2]
    ret <- cbind(Package=s,ret)
    ret <- cbind(ret,libpath=x)
    as.data.frame(ret,stringsAsFactors = FALSE)
  })

  addins <- data.table::rbindlist(addins,fill=TRUE)

  if(!is.null(fields))
    addins <- addins[,intersect(fields,colnames(addins))]

  return(addins)
}
