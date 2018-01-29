#' @title Remove user defined addin keyboard shortcuts
#' @description Command line function to remove user defined keyboard shortcuts for addins
#' @param fn character, binding of addin to remove keyboard shortcut
#' @param verbose boolean, print message of actions taken, Default: TRUE
#' @return NULL
#' @details fn expecting the form of the addin binding, ie package::function notation.
#' @rdname rm_shortcut
#' @export
#' @importFrom jsonlite write_json
rm_shortcut <- function(fn, verbose = TRUE){

  if(!.rsamEnv$write_json){
    message('rsam does not have rights to write to jsons on disk')
    invisible(return(NULL))
  }

  current_keys <- fetch_addin_keys()

  rm_idx <- current_keys$Key%in%fn

  miss_keys <- setdiff(fn,current_keys$Key)
  rm_keys <- current_keys[rm_idx,]
  new_keys <- current_keys[!rm_idx,]

  jsonlite::write_json(split(new_keys[,3],new_keys[,4]),
                       path="~/.R/rstudio/keybindings/addins.json",
                       auto_unbox = TRUE,
                       pretty = TRUE)



  if(verbose){

    if(length(miss_keys)>0){
      message('Not found in current Keyboard Settings: ', paste0(miss_keys,collapse = ','))
    }

    if(nrow(rm_keys)>0){
      for(i in 1:nrow(rm_keys)){
        message("Keyboard shortcut '",
                rm_keys$Shortcut[i],
                "' removed from '",
                rm_keys$Key[i],"'")
      }

      message('Restart RStudio to initialize')
    }


  }
}
