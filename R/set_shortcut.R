#' @title Set RStudio addin hotkeys
#' @description Helper function that sets Rstudio addin hotkeys to defaults
#' @param fn character, vector of package::function names
#' @param shortcut character, vector the same length of function_name with corresponding shortcuts
#' @param overide boolean, set to TRUE to ignore any existing shortcut, Default: FALSE
#' @param verbose boolean, set to TRUE to return a message on actions taken, Default: TRUE
#' @rdname set_shortcut
#' @importFrom jsonlite fromJSON toJSON
set_shortcut <- function(fn, shortcut, overide = FALSE, verbose = TRUE) {

  current_keys <- fetch_addins(keep_libpath = TRUE)

  if(grepl('mac',sessionInfo()[['running']])) this_os <- 'Mac'

  this_rstudio <- rstudio_shortcuts[rstudio_shortcuts$OS==this_os,-3]

  current_keys$new <- FALSE

  for(fn_idx in 1:length(fn)){
    idx <- grep(sprintf('^%s$',fn[fn_idx]),current_keys$Key)
    if(length(idx)>0){

      if(is.na(current_keys$Shortcut[idx])){
        current_keys$new[idx] <- TRUE
        current_keys$Shortcut[idx] <- shortcut[fn_idx]
      }

      if(overide&(current_keys$Shortcut[idx]!=shortcut[fn_idx])){
          current_keys$new[idx] <- TRUE
          current_keys$Shortcut[idx] <- shortcut[fn_idx]
      }
    }
  }

  new_keys <- current_keys[!is.na(current_keys$Shortcut),]

  json_now <- split(new_keys$Shortcut,new_keys$Key)

  json_now <- json_now[sort(names(json_now))]

  if(length(json_now[new_keys$new])>0){

    cat(
      jsonlite::toJSON(json_now, auto_unbox = TRUE, pretty = TRUE),
      file <- "~/.R/rstudio/keybindings/addins.json", sep = "\n"
    )

    msg <- paste0("The following addin hotkeys were set, restart RStudio to initialize\n",
                  paste0(sprintf("%s = %s",
                                 new_keys$Key[new_keys$new],
                                 new_keys$Shortcut[new_keys$new]),
                         collapse = "\n"))
  } else {
    msg <- "addin hotkeys already present"
  }

  if (verbose) {
    message(msg)
  }

}
