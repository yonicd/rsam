#' @title Toggle RStudio addins
#' @description Toggle Rstudio addins on and off by passing package::binding
#' @param key character, vector containing package::binding objects that uniquely
#'   identify addins.
#' @details a data.frame containing a summary of installed addins can be fetched through
#'   \code{\link{fetch_addins}}. Each time a Key is passed into the function the toggle will
#'   be activated for it.
#' @rdname toggle_addin
#' @export
toggle_addin <- function(key){

      default_addins <- fetch_addins()

      current_toggle <- as.data.frame(do.call('rbind',sapply(unique(gsub('_addins.dcf','_toggle',default_addins$libpath)),read.dcf)),stringsAsFactors = FALSE)

      for(idx in which(current_toggle$Key%in%key)){
        if(current_toggle$Hide[idx]=='true'){

          current_toggle$Hide[idx] <- 'false'

        }else{

          current_toggle$Hide[idx] <- 'true'

        }
      }

      new_addins <- merge(default_addins,current_toggle,by = 'Key')

      new_toggle <- split(new_addins,new_addins$Package)

      new_dcf <- split(new_addins,new_addins$Package)

      junk <- lapply(new_dcf,function(dat){
        fl <- gsub('_addins.dcf$','addins.dcf',dat$libpath[1])

        dat <- dat[dat$Hide=='false',]

        if(nrow(dat)==0){
          if(file.exists(fl))
          unlink(fl,force = TRUE)
        }else{
          write.dcf(as.matrix(dat[,c('Name','Description','Binding','Interactive')]),file=fl)
        }
      })

      junk <- lapply(new_toggle,function(dat){
        write.dcf(as.matrix(dat[,c('Key','Hide')]),
                  file=gsub('_addins.dcf$','_toggle',dat$libpath[1]))
      })

}
