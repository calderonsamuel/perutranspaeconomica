#' Iniciar consulta de transparencia economica
#' 
#' @inheritParams api_gasto
#' @param psize Cantidad máxima de filas del resultado. No cambiar a menos que se sepa con mucha seguridad lo que implica.
#' @return Un data.frame con clase `<transpaeco>`
#' @export
iniciar_transparencia_economica <- function(modulo = "gasto", actualizacion = "diaria", psize = 1000L) {
    transpaeco(modulo = modulo, actualizacion = actualizacion, psize = psize)
}
