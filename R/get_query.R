get_query <- function(x) UseMethod("get_query")

#' @export
get_query.sep_df <- function(x) attr(x, "query")




get_actualizacion <- function(x) UseMethod("get_actualizacion")

#' @export
get_actualizacion.sep_df <- function(x) attr(x, "actualizacion")
