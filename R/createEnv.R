.creatEnv <- function() {
  .rsamEnv <- new.env()
  .rsamEnv$json_no <- FALSE
  .rsamEnv$dcf_no <- FALSE
  .rsamEnv$set <- FALSE

  assign(".rsamEnv", envir = parent.frame(), value = .rsamEnv)

  return(.rsamEnv)
}

.creatEnv()
