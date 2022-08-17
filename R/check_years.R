check_years <- function(years) {
    if (is.null(years)) {
        cli::cli_abort("Debe especificar año de búsqueda usando `choose_years()`")
    }
    if (is.list(years)) {
        cli::cli_abort("Años deben especificarse en un vector numérico")
    }
    if(!all(years %in% seq(from = 2012, to = current_year()))) {
        cli::cli_abort("Año debe estar entre 2012 y {current_year()}")
    }
    TRUE
}
