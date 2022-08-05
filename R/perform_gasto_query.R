#' Ejecutar consulta de transparencia economica
#'
#' @param gasto_query Lista de parámetros de query provistos por `make_gasto_query()`
#' @inheritParams set_req_url_query
#'
#' @return Un tibble con los datos consultados
#' @export
#'
#' @examples
#' make_gasto_query(2022) |> perform_gasto_query()
perform_gasto_query <- function(gasto_query, actualizacion = "diaria") {

    request <- set_req_url_query(actualizacion = actualizacion)
    query_params <- purrr::list_modify(.req = request, gasto_query)
    year <- gasto_query$y

    do.call(httr2::req_url_query, query_params) |>
        retrieve_html_body() |>
        retrive_response_tbl() |>
        process_tbl(year = year)
}
