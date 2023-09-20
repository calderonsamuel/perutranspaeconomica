consultar2 <- S7::new_generic("consultar2", "x")

S7::method(consultar2, transpaeco) <- function(x) {
    
    check_pre_consulta(x)
    
    request <- S7::prop(x, "base_request")
    expanded <- create_query_grid(x)
    
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
        purrr::list_rbind()
    
    cli::cli_alert_success("Consultas realizadas y unificadas")
    
    consultas_unificadas
}

check_pre_consulta <- function(x) {
    current_periodo <- x@parametros@periodo_anual$periodo
    current_nivel_desagregacion <- S7::prop(x, "nivel_desagregacion")
    
    if (is.null(current_periodo)) {
        cli::cli_abort("Se requiere {.code elegir_periodo_anual()}")
    }
    
    if (current_nivel_desagregacion == 0 && !periodo_is_the_only_param(x@traduccion)) {
        cli::cli_abort("Se debe elegir un parametro de desagregacion con {.str todos}")
    }
}
