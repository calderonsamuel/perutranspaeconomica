#' Iniciar consulta de transparencia economica
#' 
#' @param actualizacion chr. Uno de c("mensual", "diaria")
#' @param modulo chr. Uno de c("gasto", "ingreso")
#' @param psize Cantidad máxima de filas del resultado. No cambiar a menos que se sepa con mucha seguridad lo que implica.
#' @return Un data.frame con clase `<transpaeco>`
#' @export
iniciar_transparencia_economica <- function(modulo = "gasto", actualizacion = "diaria", psize = 1000L) {
    transpaeco(modulo = modulo, actualizacion = actualizacion, psize = psize)
}
