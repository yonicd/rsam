.creatEnv <- function() {
  .rsamEnv <- new.env()
  .rsamEnv$json_no <- TRUE
  .rsamEnv$dcf_no <- TRUE
  .rsamEnv$set <- TRUE

  assign(".rsamEnv", envir = parent.frame(), value = .rsamEnv)

  return(.rsamEnv)
}

.creatEnv()
