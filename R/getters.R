get_query <- function(x) UseMethod("get_query")

#' @export
get_query.sep_df <- function(x) {
    attr(x, "query") |>
        purrr::discard(is.null)
}




get_actualizacion <- function(x) UseMethod("get_actualizacion")

#' @export
get_actualizacion.sep_df <- function(x) attr(x, "actualizacion")




get_req_url <- function(x) UseMethod("get_req_url")

#' @export
get_req_url.sep_df <- function(x) {
    attr(x, "req_url")
}



get_modulo <- function(x) UseMethod("get_modulo")


#' @export
get_modulo.sep_df <- function(x) attr(x, "modulo")
