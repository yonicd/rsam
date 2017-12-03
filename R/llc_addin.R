lla1 <- function(){

  do.call(get('rsam_fn_1',envir = parent.frame(2)),args = list())

}

lla2 <- function(){

  do.call(get('rsam_fn_2',envir = parent.frame(2)),args = list())

}


lla3 <- function(){

  do.call(get('rsam_fn_3',envir = parent.frame(2)),args = list())

}
