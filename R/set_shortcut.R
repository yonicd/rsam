#' @title Set RStudio Addin Keyboard Shortcuts
#' @description Helper function that sets Rstudio addin keyboard shortcuts
#' @param fn character, vector of package::function names
#' @param shortcut character, vector the same length of fn with corresponding shortcuts
#' @param overide boolean, set to TRUE to ignore any existing shortcut, Default: FALSE
#' @param verbose boolean, set to TRUE to return a message on actions taken, Default: TRUE
#' @rdname set_shortcut
#' @export
#' @importFrom jsonlite write_json
set_shortcut <- function(fn, shortcut, overide = FALSE, verbose = TRUE) {

  if(.rsamEnv$json_no){
    message('rsam does not have rights to write to jsons on disk')
    invisible(return(NULL))
  }

  if(length(fn)!=length(unique(fn)))
    stop('fn values must be unique')

  fn <- unique(fn)

  if(length(shortcut)!=length(unique(shortcut)))
    stop('shorcut values must be unique')

  shortcut <- unique(shortcut)

  if(length(fn)!=length(shortcut))
    stop('fn, shortcut must be same length')

  not_found <- FALSE

  current_keys <- fetch_addins()

  if(is.null(current_keys$Shortcut))
    current_keys$Shortcut <- NA

  current_keys$new <- FALSE

  for(fn_idx in 1:length(fn)){
    idx <- grep(sprintf('^%s$',fn[fn_idx]),current_keys$Key)
    if(length(idx)>0){

      if(is.na(current_keys$Shortcut[idx])){
        current_keys$new[idx] <- TRUE
        current_keys$Shortcut[grep(shortcut[fn_idx],current_keys$Shortcut)] <- NA
        current_keys$Shortcut[idx] <- shortcut[fn_idx]
      }

      if(overide&(current_keys$Shortcut[idx]!=shortcut[fn_idx])){
          current_keys$new[idx] <- TRUE
          current_keys$Shortcut[grep(shortcut[fn_idx],current_keys$Shortcut)] <- NA
          current_keys$Shortcut[idx] <- shortcut[fn_idx]
      }
    }else{

      not_found <- TRUE

      if (verbose) {
        message('* Addin binding not found: ', fn[fn_idx])
      }
    }
  }

  new_keys <- current_keys[!is.na(current_keys$Shortcut),c('Shortcut','Key','new')]

  if(sum(new_keys$new)>0){

    jsonlite::write_json(split(new_keys[,1],new_keys[,2]),
                         path="~/.R/rstudio/keybindings/addins.json",
                         auto_unbox = TRUE,
                         pretty = TRUE)

    msg <- paste0("* The following addin keyboard shorcuts were set, restart RStudio to initialize\n",
                  paste0(sprintf("%s = %s",
                                 new_keys$Key[new_keys$new],
                                 new_keys$Shortcut[new_keys$new]),
                         collapse = "\n"))
  } else {
    msg <- "\n* Addin shortcuts unchanged"
  }

  if (verbose) {

    if(not_found)
      msg <- sprintf('%s\n\n* For a summary of installed Addin Bindings run rsam::fetch_addins()',msg)

    message(msg)
  }

}
