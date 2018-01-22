#' @title Writes _rsam.yml to home directory
#' @description Writes ~/_rsam.yml to bypass rsam onattach/onload prompt menu
#' @param overwrite boolean, if TRUE will set output file to defaults, Default: FALSE
#' @details
#' Default Settings:
#'
#' \tabular{lll}{
#' \strong{field} \tab \strong{description} \tab \strong{setting}\cr
#' json_no \tab Permission to write ~/.R/rstudio/keybindings/addins.json                     \tab FALSE\cr
#' dcf_no  \tab Permission to duplicate rstudio/addins.dcf of installed packages with addins \tab FALSE\cr
#' silent  \tab Permission to run onload/onattach script run with messages to console        \tab  TRUE
#'}
#'
#' @return NOTHING
#' @rdname create_yml
#' @export
#' @importFrom yaml write_yaml
create_yml <- function(overwrite=FALSE){

  this_file <- '~/_rsam.yml'

  x <- data.frame(json_no=FALSE,
                  dcf_no=FALSE,
                  silent=TRUE,
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
