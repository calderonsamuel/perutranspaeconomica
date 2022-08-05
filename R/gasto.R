#' Consulta de ejecución presupuestal
#'
#' @param year Año para el cual se quiere obtener la información a partir de 1999.
#' @param actualizacion Puede ser "diaria" o "mensual"
#' @param ... Otros argumentos pasados a `make_gasto_query()`
#'
#' @return Un tibble con la información requerida
#' @export
#'
gasto <- function(year, ..., actualizacion = "diaria") {
    set_req_url_query(actualizacion = actualizacion) |>
        gasto_query(year = year, ...) |>
        retrieve_html_body() |>
        retrive_response_tbl() |>
        process_tbl(year = year)
}


separate_cod_desc <- function(.data, .num_col = 2L) {
    col_name <- names(.data[, .num_col])
    if (col_name == "na_2") return(.data |> dplyr::rename(total = na_2))
    cod_col <- glue::glue("cod_{col_name}")
    desc_col <- glue::glue("desc_{col_name}")

    .data |>
        tidyr::separate(col = .num_col, into = c(cod_col, desc_col), sep = ": ", extra = "merge")
}

process_tbl <- function(tbl, year) {
    tbl |>
        dplyr::mutate(year = year) |>
        dplyr::relocate(year) |>
        janitor::remove_empty("cols") |>
        dplyr::distinct(dplyr::across()) |>
        dplyr::filter(!is.na(readr::parse_number(pia))) |>
        separate_cod_desc() |>
        dplyr::mutate(dplyr::across(pia:avance_percent, readr::parse_number)) |>
        suppressWarnings()
}

perform_gasto_query <- function(gasto_query, actualizacion = "diaria") {

    request <- set_req_url_query(actualizacion = actualizacion)
    query_params <- purrr::list_modify(.req = request, gasto_query)
    year <- gasto_query$y

    do.call(httr2::req_url_query, query_params) |>
        retrieve_html_body() |>
        retrive_response_tbl() |>
        process_tbl(year = year)
}

