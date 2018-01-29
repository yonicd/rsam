.creatEnv <- function() {
  .rsamEnv <- new.env()
  .rsamEnv$write_json <- FALSE
  .rsamEnv$write_dcf <- FALSE
  .rsamEnv$set <- TRUE

  assign(".rsamEnv", envir = parent.frame(), value = .rsamEnv)

  return(.rsamEnv)
}

.creatEnv()
