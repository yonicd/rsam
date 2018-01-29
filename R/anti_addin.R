#' @title Create duplicate of addins.dcf file in installed packages.
#' @description Create duplicates of installed addins.dcf of packages with addins
#'  found in libpath that rsam will manipulate
#' @return nothing
#' @rdname anti_addin
#' @export
#' @importFrom utils installed.packages
anti_addin <- function(){

  if(!.rsamEnv$write_dcf){
    message('rsam does not have rights to write to dcf on disk')
    invisible(return(NULL))
  }

  inst_pkgs <- utils::installed.packages()[,c(1,2)]
  inst_pkgs1 <- file.path(inst_pkgs[,2],inst_pkgs[,1],'rstudio','addins.dcf')

  addin_pkgs <- inst_pkgs1[which(file.exists(inst_pkgs1))]
  addin_pkgs2 <- gsub('addins.dcf$','_addins.dcf',
                      inst_pkgs1[which(file.exists(gsub('addins.dcf$','_addins.dcf',inst_pkgs1)))])

  check_addins <- sort(c(addin_pkgs,addin_pkgs2))

  check_pkgs <- unlist(lapply(strsplit(check_addins,'/'),function(x) x[length(x)-2]))

  check <- data.frame(check_addins,check_pkgs,stringsAsFactors = FALSE)

  check <- split(check,check$check_pkgs)

  addin_pkgs <- sapply(check,function(x){
    x[nrow(x),1]
  },USE.NAMES = FALSE,simplify = TRUE)

  names(addin_pkgs) <- NULL

  anti_addins <- gsub('/addins.dcf$','/_addins.dcf',addin_pkgs)
  toggle_addins <- gsub('/addins.dcf$','/_toggle',addin_pkgs)

  for(idx in 1:length(addin_pkgs)){
    if(!file.exists(anti_addins[idx]))
      file.copy(addin_pkgs[idx],anti_addins[idx],overwrite = FALSE)
  }

  pkgs <- sapply(strsplit(anti_addins,'/'),function(x){
    x[length(x)-2]
  })

  current_keys <- fetch_addin_keys()

    for(this_pkg in pkgs){
      this_dcf <- read.dcf(anti_addins[grep(this_pkg,pkgs)])

      this_key <- paste(this_pkg,this_dcf[,'Binding'],sep='::')

      if(!'Key'%in%colnames(this_dcf))
        this_dcf <- cbind(this_dcf,Key=this_key)

      if(!is.null(current_keys)){
        this_dcf <- cbind(this_dcf,Shortcut=NA)

        for(idx in 1:nrow(this_dcf)){
          this_dcf[idx,'Shortcut'] <- current_keys$Shortcut[match(this_dcf[idx,'Key'],current_keys$Key)]
        }
      }

      write.dcf(this_dcf,file = anti_addins[grep(this_pkg,pkgs)])

      if(!file.exists(toggle_addins[grep(this_pkg,pkgs)])){
        write.dcf(cbind(Key=this_key,Hide='false'),file=toggle_addins[grep(this_pkg,pkgs)])
      }
    }

  return(invisible(anti_addins))
}
