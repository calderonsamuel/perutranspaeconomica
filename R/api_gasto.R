#' Escoger API de gasto segun actualizacion
#'
#' @param actualizacion chr. Uno de c("mensual", "diaria")
#'
#' @return chr. La URL base de una API de seguimiento a la ejecucion del gasto
#'
api_gasto <- function(actualizacion = "mensual") {
    tipo_act <- match.arg(actualizacion, c("mensual", "diaria"))
    switch(tipo_act,
        mensual = "https://apps5.mineco.gob.pe/transparencia/mensual/Navegar_6.aspx",
        diaria = "https://apps5.mineco.gob.pe/transparencia/Navegador/Navegar_7.aspx"
    )
}
