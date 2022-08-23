check_years <- function(years) {
    if (is.null(years)) {
        cli::cli_abort("Debe especificar periodo anual de consulta usando `elegir_years()`")
    }
    if (is.list(years)) {
        cli::cli_abort("Periodo anual debe especificarse en un vector numerico")
    }
    if(!all(years %in% seq(from = 2012, to = current_year()))) {
        cli::cli_abort("Periodo anual debe estar entre 2012 y {current_year()}")
    }
    TRUE
}
