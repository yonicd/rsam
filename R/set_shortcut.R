#' @title Set RStudio Addin Keyboard Shortcuts
#' @description Helper function that sets Rstudio addin keyboard shortcuts
#' @param fn character, vector of package::function names
#' @param shortcut character, vector the same length of fn with corresponding shortcuts
#' @param overide boolean, set to TRUE to ignore any existing shortcut, Default: FALSE
#' @param verbose boolean, set to TRUE to return a message on actions taken, Default: TRUE
#' @rdname set_shortcut
#' @export
set_shortcut <- function(fn, shortcut, overide = FALSE, verbose = TRUE) {

  current_keys <- fetch_addins(keep_libpath = TRUE)

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
    }
  }

  new_keys <- current_keys[!is.na(current_keys$Shortcut),c('Shortcut','Key','new')]

  if(sum(new_keys$new)>0){

    nr <- nrow(new_keys)

    cat(
      c('{',
        sprintf('  "%s": "%s",',new_keys$Key[-nr],new_keys$Shortcut[-nr]),
        sprintf('  "%s": "%s"',new_keys$Key[nr],new_keys$Shortcut[nr])
        ,'}\n'),
      file = "~/.R/rstudio/keybindings/addins.json",
      sep = "\n"
    )

    msg <- paste0("The following addin keyboard shorcuts were set, restart RStudio to initialize\n",
                  paste0(sprintf("%s = %s",
                                 new_keys$Key[new_keys$new],
                                 new_keys$Shortcut[new_keys$new]),
                         collapse = "\n"))
  } else {
    msg <- "addin shortcuts already present"
  }

  if (verbose) {
    message(msg)
  }

}
