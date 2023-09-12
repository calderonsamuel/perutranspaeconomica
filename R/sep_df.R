# constructor
#' @importFrom tibble tibble
#' @noRd
new_sep_df <- function(query = query,
                       modulo = "gasto",
                       actualizacion = "diaria"
                       ) {
    x <- tibble()
    class(x) <- c("sep_df", class(x))
    attr(x, "modulo") <- modulo
    attr(x, "actualizacion") <-  actualizacion
    attr(x, "query") <-  query
    attr(x, "req_url") <-  set_req_url_query(actualizacion = actualizacion, modulo = modulo)
    x
}


# helper
#' @noRd
sep_df <- function(query = list(), modulo = "gasto", actualizacion = "diaria") {

    new_sep_df(query = query,
               modulo = modulo,
               actualizacion = actualizacion)
}

