#' Iniciar consulta de transparencia economica
#' 
#' @inheritParams api_gasto
#' @return Un data.frame con clase `<transpaeco>`
#' @export
iniciar_transparencia_economica <- function(modulo = "gasto", actualizacion = "diaria") {
    transpaeco(modulo = modulo, actualizacion = actualizacion)
}
