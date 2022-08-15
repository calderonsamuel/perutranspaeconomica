# constructor
#' @noRd
new_sep_df <- function(x = tibble::tibble(), query = list(), actualizacion = "diaria") {
    class(x) <- c("sep_df", class(x))
    attr(x, "actualizacion") <-  actualizacion
    attr(x, "query") <-  query
    x
}


# helper
#' @noRd
sep_df <- function(query = list(), actualizacion = "diaria") {
    new_sep_df(query = query, actualizacion = actualizacion)
}



# exposed API
sep <- function(..., actualizacion = "diaria") {
    query <- list(...)
    sep_df(query = query, actualizacion = actualizacion)
}




#' @noRd
query_is_empty <- function(x) {
    query <- get_query(x)
    length(query) == 0
}

# sep_df()

# sep(year = 2020)


