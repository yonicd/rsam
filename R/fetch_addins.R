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

  if(is.null(addin_pkgs)) invisible(return(NULL))

  addins <- lapply(addin_pkgs,function(x){
    ret <- read.dcf(x)
    s <- strsplit(x,'/')[[1]]
    s <- s[length(s)-2]
    ret <- cbind(Package=s,ret)
    ret <- cbind(ret,libpath=x)
    as.data.frame(ret,stringsAsFactors = FALSE)
  })

  addins <- data.table::rbindlist(addins,fill=TRUE)

  if(!'Shortcut'%in%names(addins)) addins$Shortcut <- NA

  if(!is.null(fields))
    addins <- addins[,intersect(fields,colnames(addins))]

  return(addins)
}
