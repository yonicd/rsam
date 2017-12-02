#' @title Restore package addins
#' @description Restores addins.dcf files of installed package
#' @param package character, packages to restore default addins, if NULL all packages will
#' be restored, Default: NULL
#' @rdname restore_addins
#' @export
restore_addins <- function(package=NULL){

  current_keys <- fetch_addins(fields = c('Package','libpath'))

  restore_pkg <- current_keys[match(unique(current_keys$Package),current_keys$Package),]

  if(!is.null(package))
    restore_pkg <- restore_pkg[restore_pkg$Key%in%package,]

  sapply(restore_pkg$libpath,function(x){
    file.copy(x,gsub('_addins.dcf$','addins.dcf',x),overwrite = TRUE)
  })

  return(invisible(NULL))

}
