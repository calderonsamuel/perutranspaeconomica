#' Escoger API de gasto segun actualizacion
#'
#' @param actualizacion chr. Uno de c("mensual", "diaria")
#'
#' @return chr. La URL base de una API de seguimiento a la ejecucion del gasto
#'
api_gasto <- function(actualizacion = "mensual", modulo = "gasto") {

    if (!modulo %in% c("gasto", "ingreso")) {
        cli::cli_abort("{.code modulo} debe ser {.str gasto} o {.str ingreso}")
    }

    if (! actualizacion %in% c("diaria", "mensual")) {
        cli::cli_abort("{.code actualizacion} debe ser {.str diaria} o {.str mensual}")
    }

    api <- list(
        gasto = list(
            diaria = "https://apps5.mineco.gob.pe/transparencia/Navegador/Navegar_7.aspx",
            mensual = "https://apps5.mineco.gob.pe/transparencia/mensual/Navegar_6.aspx"
        ),
        ingreso = list(
            diaria = "https://apps5.mineco.gob.pe/transparenciaingresos/Navegador/Navegar_6.aspx",
            mensual = "https://apps5.mineco.gob.pe/transparenciaingresos/mensual/Navegar_6.aspx"
        )
    )

    api[[modulo]][[actualizacion]]

}
