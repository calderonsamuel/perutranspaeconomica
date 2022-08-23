#' Elegir periodo anual de consulta
#'
#' @inheritParams consultar
#' @param years numeric. Periodo anual de consulta
#' @return sep_df
#' @export
elegir_years <- function(x, years) UseMethod("elegir_years")

#' @export
elegir_years.sep_df <- function(x, years = current_year()) {
    check_years(years)
    query <- get_query(x)
    new_years <- list(years)
    query <- purrr::list_modify(query, years = new_years)
    attr(x, "query") <- query
    x
}
