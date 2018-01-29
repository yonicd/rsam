#' @importFrom jsonlite write_json
#' @importFrom yaml read_yaml
.onLoad <- function(libname, pkgname) {

  if(file.exists('~/_rsam.yml')){
    this_yml <- yaml::read_yaml('~/_rsam.yml')

    assign("set", envir = .rsamEnv, FALSE)
    assign("write_json", envir = .rsamEnv, this_yml$write_json)
    assign("write_dcf", envir = .rsamEnv, this_yml$write_dcf)

  }

  if(interactive()&.rsamEnv$set){

    assign("set", envir = .rsamEnv, FALSE)

    .rsamEnv$write_json <- yesno('Do you agree to let {rsam} manipulate the addins\njsons used to manage RStudio addin keyboard shortcuts?')
    .rsamEnv$write_dcf <- yesno('Do you agree to let {rsam} duplicate the dcf files of the installed addins in your .libPaths\nand manipulate them to manage RStudio Addins dropdown list?')
  }

  key_dir <- '~/.R/rstudio/keybindings'

  if(!dir.exists(key_dir)&.rsamEnv$write_json){

    dir.create('~/.R/rstudio/keybindings',showWarnings = FALSE,recursive = TRUE)

    for(this_file in paste0(c('addins','editor_bindings','rstudio_bindings'),'.json'))
      jsonlite::write_json(c(), path = file.path(key_dir,this_file))
  }
}


#' @importFrom jsonlite write_json
#' @importFrom yaml read_yaml
.onAttach <- function(libname, pkgname) {

  if(file.exists('~/_rsam.yml')){
    this_yml <- yaml::read_yaml('~/_rsam.yml')

    assign("set", envir = .rsamEnv, FALSE)
    assign("write_json", envir = .rsamEnv, this_yml$write_json)
    assign("write_dcf", envir = .rsamEnv, this_yml$write_dcf)

    if(this_yml$verbose){
      packageStartupMessage('rsam persmissions set by ~/_rsam.yml')
    }


  }

  if(interactive()&.rsamEnv$set){

    assign("set", envir = .rsamEnv, FALSE)

    .rsamEnv$write_json <- yesno('Do you agree to let {rsam} manipulate the addins\njsons used to manage RStudio addin keyboard shortcuts?')
    .rsamEnv$write_dcf <- yesno('Do you agree to let {rsam} duplicate the dcf files of the installed addins in your .libPaths\nand manipulate them to manage RStudio Addins dropdown list?')

  }

  key_dir <- '~/.R/rstudio/keybindings'

  if(!dir.exists(key_dir)&.rsamEnv$write_json){

    dir.create('~/.R/rstudio/keybindings',showWarnings = FALSE,recursive = TRUE)

    for(this_file in paste0(c('addins','editor_bindings','rstudio_bindings'),'.json'))
      jsonlite::write_json(c(), path = file.path(key_dir,this_file))
  }
}
