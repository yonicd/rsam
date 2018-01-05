#' @title Keyboard Validation
#' @description List containing keyboard keys
#' @format A list with 99 elements of class 'key'
#' @details key class has a '.+' method so keys can be appended to each other
#' @examples
#' base_key <- KEYS$`left command/window key`
#' base_key
#' base_key + KEYS$shift + KEYS$i
#' base_key + KEYS[2:9]
#'
"KEYS"
