#' @title Writes _rsam.yml to home directory
#' @description Writes ~/_rsam.yml to bypass rsam onattach/onload prompt menu
#' @param overwrite boolean, if TRUE will set output file to defaults, Default: FALSE
#' @details
#' Default Settings:
#'
#' \tabular{lll}{
#' \strong{field} \tab \strong{description} \tab \strong{setting}\cr
#' write_json \tab Permission to write ~/.R/rstudio/keybindings/addins.json                     \tab TRUE\cr
#' write_dcf  \tab Permission to duplicate rstudio/addins.dcf of installed packages with addins \tab TRUE\cr
#' verbose  \tab Permission to run onLoad/onAttach script run with messages to console        \tab  TRUE
#'}
#'
#' @return NOTHING
#' @rdname create_yml
#' @export
#' @importFrom yaml write_yaml
create_yml <- function(overwrite=FALSE){

  this_file <- '~/_rsam.yml'

  x <- data.frame(write_json=TRUE,
                  write_dcf=TRUE,
                  verbose=TRUE,
                  stringsAsFactors = FALSE)

  if(interactive()){
    if(!file.exists(this_file)){
        yaml::write_yaml(x,file = this_file)
    }else{
      if(overwrite){
        yaml::write_yaml(x,file = this_file)
      }
    }
  }

}
