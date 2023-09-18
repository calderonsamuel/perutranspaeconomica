consultar2 <- S7::new_generic("consultar2", "x")

S7::method(consultar2, transpaeco) <- function(x) {
    
    if (S7::prop(x, "nivel_desagregacion") != 1L) {
        cli::cli_abort("Debe haber siempre una propiedad con valor {.str todos}")
    }
    
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
