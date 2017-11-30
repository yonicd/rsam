#' @title Current Addins
#' @description Retrieve current installed Addins
#' @param keep_libpath boolean, keep package libpath in output object, Default: FALSE
#' @return data.frame
#' @rdname fetch_addins
#' @export
#' @importFrom utils installed.packages
fetch_addins <- function(keep_libpath=FALSE){

  addin_pkgs <- anti_addin()

  addins <- lapply(addin_pkgs,function(x){
    ret <- read.dcf(x)
    s <- strsplit(x,'/')[[1]]
    s <- s[length(s)-2]
    ret <- cbind(Package=s,ret)
    if(keep_libpath)
      ret <- cbind(ret,libpath=x)
    as.data.frame(ret,stringsAsFactors = FALSE)
  })

  addins <- data.table::rbindlist(addins,fill=TRUE)

  return(addins)
}
