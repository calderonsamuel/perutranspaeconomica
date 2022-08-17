check_years <- function(years) {
    if(length(years) != 1) {
        cli::cli_abort("Debe indicar solo 1 año de consulta")
    }
    if(!years %in% seq(from = 2012, to = current_year())) {
        cli::cli_abort("Año debe estar entre 2012 y {current_year()}")
    }
    TRUE
}
