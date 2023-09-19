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
        purrr::pmap(tibble::tibble)

    cli::cli_alert_info("Iniciando consulta")
    
    consultas_recibidas <- splitted |>
        purrr::map(
            .f = ejecutar_consulta_individual,
            .progress = list(name = "Ejecutando consulta", type = "tasks"),
            request
        )

    cli::cli_alert_info("Unificando consultas...")

    consultas_unificadas <- consultas_recibidas |>
        purrr::list_rbind() |>
        inherit_attr(inherit_from = x)

    cli::cli_alert_success("Consultas realizadas y unificadas")

    consultas_unificadas
}

ejecutar_consulta_individual <- function(query_params, request) {
    lista_amigable <- as.list(query_params)
    lista_translated <- sep_params_translate(lista_amigable)
    
    if (!years_is_only_param(query_params)) {
        lista_translated <- empty_str_to_last(lista_translated)
    }
    
    tabla <- request |> 
        httr2::req_url_query(!!!lista_translated) |> 
        httr2::req_perform() |> 
        retrieve_html_body() |>
        retrieve_response_tbl() |>
        process_tbl()

    lista_amigable |>
        tibble::as_tibble() |>
        dplyr::mutate(tabla = list(tabla), .before = 1) |>
        tidyr::unnest(tabla) |>
        dplyr::relocate(periodo, .before = 1)
}


inherit_attr <- function(new_df, inherit_from) {
    class(new_df) <- c("sep_df", class(new_df))
    attr(new_df, "modulo") <- attr(inherit_from, "modulo")
    attr(new_df, "actualizacion") <-  attr(inherit_from, "actualizacion")
    attr(new_df, "query") <-  attr(inherit_from, "query")
    attr(new_df, "req_url") <-  attr(inherit_from, "req_url")
    new_df
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
    (length(query) == 1L) && (names(query) == "periodo")
}
