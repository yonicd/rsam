#' @importFrom jsonlite write_json
.onLoad <- function(libname, pkgname) {
  key_dir <- '~/.R/rstudio/keybindings'

  if(!dir.exists(key_dir)){

    dir.create('~/.R/rstudio/keybindings',showWarnings = FALSE,recursive = TRUE)

    for(this_file in paste0(c('addins','editor_bindings','rstudio_bindings'),'.json'))
      jsonlite::write_json(c(), path = file.path(key_dir,this_file))

  }
}

#' @importFrom jsonlite write_json
.onAttach <- function(libname, pkgname) {
  key_dir <- '~/.R/rstudio/keybindings'

  if(!dir.exists(key_dir)){

    dir.create('~/.R/rstudio/keybindings',showWarnings = FALSE,recursive = TRUE)

    for(this_file in paste0(c('addins','editor_bindings','rstudio_bindings'),'.json'))
      jsonlite::write_json(c(), path = file.path(key_dir,this_file))

  }
}
