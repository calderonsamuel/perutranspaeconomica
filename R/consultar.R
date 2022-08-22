#' Ejecutar consulta de seguimiento a la ejecución presupuestal
#'
#' @param x Objeto de clase 'sep_df' recipiente de los parámetros de la consulta deseada
#'
#' @return sep_df. Tabla que contiene el resultado de la consulta solicitada
#' @export
consultar <- function(x) UseMethod("consultar")

#' @export
consultar.sep_df <- function(x) {
    request <- get_req_url(x)
    expanded <- expand_query(x)

    splitted <- expanded |>
        split_by_row()

    n_consultas <- length(splitted)
    consultas_recibidas <- vector("list", length = n_consultas)

    cli::cli_alert_info("Iniciando consulta")

    cli::cli_progress_bar("Ejecutando consulta", total = n_consultas, type = "tasks")

    for(i in seq_len(n_consultas)) {
        consultas_recibidas[[i]] <- ejecutar_consulta_individual(splitted[[i]], request)
        cli::cli_progress_update()
    }

    cli::cli_progress_done()

    cli::cli_alert_info("Unificando consultas...")

    consultas_unificadas <- consultas_recibidas |>
        purrr::map_dfr(~.x) |>
        inherit_attr(inherit_from = x)

    cli::cli_alert_success("Consultas realizadas y unificadas")

    consultas_unificadas
}

ejecutar_consulta_individual <- function(query_params, request) {
    lista <- as.list(query_params)
    if (!years_is_only_param(query_params)) {
        lista <- empty_str_to_last(lista)
    }

    year <- lista$y
    params <- purrr::list_modify(.req = request, lista)
    do.call(httr2::req_url_query, params) |>
        retrieve_html_body() |>
        retrive_response_tbl() |>
        process_tbl(year = year)
}

split_by_row <- function(.df) {
    .df[[".id"]] <- seq_len(nrow(.df))
    .df |>
        split(~.id) |>
       lapply(\(.x){
            .x[[".id"]] <- NULL
            .x
        })
}

inherit_attr <- function(new_df, inherit_from) {
    class(new_df) <- c("sep_df", class(new_df))
    attr(new_df, "modulo") <- attr(inherit_from, "modulo")
    attr(new_df, "actualizacion") <-  attr(inherit_from, "actualizacion")
    attr(new_df, "query") <-  attr(inherit_from, "query")
    attr(new_df, "req_url") <-  attr(inherit_from, "req_url")
    new_df
}

#' @noRd
expand_query <- function(x) UseMethod("expand_query")

#' @export
expand_query.sep_df <- function(x) {
    query <- get_query(x) |> purrr::flatten()
    check_years(query$years)
    translated <- sep_params_translate(query)
    expanded <- do.call(tidyr::expand_grid, translated)
    expanded
}

empty_str_to_last <- function(x) {
    empty_str <- purrr::keep(x, ~.x == "")
    empty_str_name <- names(empty_str)
    empty_str_value <- empty_str[[1]]
    remaining <- purrr::discard(x, ~.x == "")
    remaining[[empty_str_name]] <- empty_str_value
    remaining
}

years_is_only_param <- function(query) {
    qn <- names(query)
    length(qn) == 1 && qn == "y"
}
