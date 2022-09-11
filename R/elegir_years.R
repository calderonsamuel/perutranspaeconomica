#' Elegir periodo anual de consulta
#'
#' @inheritParams consultar
#' @param periodo numeric. Periodo anual de consulta
#' @return sep_df
#' @export
elegir_periodo_anual <- function(x, periodo) UseMethod("elegir_periodo_anual")

#' @export
elegir_periodo_anual.sep_df <- function(x, periodo = current_year()) {
    check_years(periodo)
    query <- get_query(x)
    new_years <- list(periodo)
    query <- purrr::list_modify(query, periodo = new_years)
    attr(x, "query") <- query
    x
}
