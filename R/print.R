#' @export
print.sep_df <- function(x) {
    cli_titulo(x)
    cli::cli_h2("Parámetros de consulta")
    cli_query(x)
    cli::cli_h2("Data")
    if(nrow(x) == 0) cli_sin_consulta() else NextMethod()
    invisible(x)
}

cli_query <- function(x) {
    if (query_is_empty(x)) {
        cli::cli_alert_info("No se ha definido parámetros de consulta")
    }
}

cli_sin_consulta <- function() {
    cli::cli_alert_info("No se ha ejecutado ninguna consulta")
}

cli_titulo <- function(x) {
    actualizacion <- get_actualizacion(x)
    cli::cli_h1("Seguimiento a la ejecución presupuestal ({.emph actualización {actualizacion}})")
}

# SeguimientoEjecucion$set("public", "print", function() {
#     cli::cli_h1("Seguimiento a la ejecución presupuestal ({.emph {private$actualizacion}})")
#     cli::cli_h2("Parámetros de búsqueda")
#     cli::cli_ul()
#     # cli::cli_li("Actualización: {private$actualizacion}")
#     private$cli_years()
#     private$cli_quien_gasta()
#     private$cli_en_que_se_gasta()
#     private$cli_con_que_se_financia()
#     private$cli_como_se_estructura()
#     private$cli_donde_se_gasta()
#     private$cli_cuando_se_hizo_gasto()
# })
