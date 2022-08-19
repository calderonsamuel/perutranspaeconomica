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
        set_gasto_query(year = year, ...) |>
        retrieve_html_body() |>
        retrive_response_tbl() |>
        process_tbl(year = year)
}


#' @importFrom rlang .data
separate_cod_desc <- function(.dat, .num_col = 2L) {
    col_name <- names(.dat[, .num_col])
    if (col_name == "na_2") return(.dat |> dplyr::rename(total = .data$na_2))
    cod_col <- glue::glue("cod_{col_name}")
    desc_col <- glue::glue("desc_{col_name}")

    .dat |>
        tidyr::separate(col = .num_col, into = c(cod_col, desc_col), sep = ": ", extra = "merge")
}

#' @importFrom rlang .data
process_tbl <- function(tbl, year) {
    tbl |>
        dplyr::mutate(year = year) |>
        dplyr::relocate(year) |>
        janitor::remove_empty("cols") |>
        dplyr::distinct(dplyr::across()) |>
        dplyr::filter(!is.na(readr::parse_number(.data$pia))) |>
        separate_cod_desc() |>
        dplyr::mutate(dplyr::across(.data$pia:.data$avance_percent, readr::parse_number)) |>
        suppressWarnings()
}



