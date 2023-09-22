#' Ejecutar consulta de seguimiento a la ejecución presupuestal
#'
#' @param x Objeto de clase 'sep_df' recipiente de los parámetros de la consulta deseada
#'
#' @return Un data.frame con clase <transpaeco> que contiene el resultado de la consulta solicitada
#' @export
consultar <- S7::new_generic("consultar", "x", function(x) {
    S7::S7_dispatch()
})

S7::method(consultar, transpaeco) <- function(x) {
    
    check_pre_consulta(x)
    
    request <- S7::prop(x, "base_request")
    expanded <- create_query_grid(x)
    
    splitted <- expanded %>%
        purrr::pmap(tibble::tibble)
    
    cli::cli_alert_info("Iniciando consulta")
    
    consultas_recibidas <- splitted %>%
        purrr::map(
            .f = ejecutar_consulta_individual,
            .progress = list(name = "Ejecutando consulta", type = "tasks"),
            request
        )
    
    cli::cli_alert_info("Unificando consultas...")
    
    consultas_unificadas <- consultas_recibidas %>%
        purrr::list_rbind()
    
    cli::cli_alert_success("Consultas realizadas y unificadas")
    
    transpaeco(
        .data = consultas_unificadas,
        modulo = x@modulo,
        actualizacion = x@actualizacion,
        parametros = x@parametros
    )
}

check_pre_consulta <- function(x) {
    current_periodo <- x %>% 
        S7::prop("parametros") %>% 
        S7::prop("periodo_anual") %>% 
        purrr::pluck("periodo")
        
    current_nivel_desagregacion <- S7::prop(x, "nivel_desagregacion")
    
    if (current_nivel_desagregacion == 0 && !periodo_is_the_only_param(S7::prop(x, "traduccion"))) {
        cli::cli_abort("Se debe elegir un parametro de desagregacion con {.str todos}")
    }
}

ejecutar_consulta_individual <- function(query_params, request) {
    lista_amigable <- as.list(query_params)
    lista_translated <- translate_params_list(lista_amigable)
    
    if (!periodo_is_the_only_param(query_params)) {
        lista_translated <- empty_str_to_last(lista_translated)
    }
    
    tabla <- request %>% 
        httr2::req_url_query(!!!lista_translated) %>% 
        httr2::req_perform() %>% 
        retrieve_html_body() %>%
        retrieve_response_tbl() %>%
        process_tbl()
    
    lista_amigable %>%
        tibble::as_tibble() %>%
        dplyr::mutate(tabla = list(tabla), .before = 1) %>%
        tidyr::unnest(tabla) %>%
        dplyr::relocate("periodo", .before = 1)
}

empty_str_to_last <- function(x) {
    empty_item_name <- purrr::keep(x, ~.x == "") %>% names()
    x[[empty_item_name]] <- NULL
    x[[empty_item_name]] <- ""
    x
}

periodo_is_the_only_param <- function(query) {
    (length(query) == 1L) && (names(query) == "periodo") 
}
