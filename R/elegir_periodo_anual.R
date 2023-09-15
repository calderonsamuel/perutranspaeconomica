elegir_periodo_anual2 <- function(x, periodo = NULL) {
    
    if (!is.numeric(periodo)) {
        cli::cli_abort("Periodo anual debe especificarse en un vector numérico")
    }
    if(!all(periodo %in% seq(from = 2012, to = current_year()))) {
        cli::cli_abort("Periodo anual debe estar entre 2012 y {current_year()}")
    }
    
    update_parameter(x, "periodo_anual", list(periodo = periodo))
}
