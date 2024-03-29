#' Elegir el tiempo en que se usa el presupuesto
#' 
#' Estas funciones permiten desglosar la busqueda de acuerdo al tiempo en el periodo anual. 
#' `elegir_cuando_se_hizo_gasto()` y `elegir_cuando_se_hizo_recaudacion()` sirven los módulos de gasto e ingresos, respectivamente.
#' `elegir_tiempo()` es una versión agnóstica que sirve para ámbos módulos.
#' Al desglosar por mes o trimestre se pierde información de PIA, PIM 
#' y porcentaje de avance (en *gasto*).
#'
#' @inheritParams consultar
#' @param trimestre int. Número del 1 al 4
#' @param mes int. Número del 1 al 12. 
#'
#' @inherit iniciar_transparencia_economica return
#' @export
#' 
#' @examples
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_cuando_se_hizo_gasto(mes = "todos")
#' 
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_cuando_se_hizo_gasto(mes = "todos") %>%
#'     consultar()
#' 
#' # se emite mensaje de error si se intenta elegir periodos no abarcados
#' tryCatch({
#'     iniciar_transparencia_economica(modulo = "gasto") %>%
#'         elegir_periodo_anual(periodo = 2022) %>%
#'         elegir_cuando_se_hizo_gasto(trimestre = "5")
#'         
#' }, error = function(e) print(e))
#' 
elegir_tiempo <- function(x,
                          trimestre = NULL,
                          mes = NULL) {
    
    update_list <- list(
        trimestre = trimestre,
        mes = mes
    )
    
    names(update_list) <- names(update_list) %>%
        paste0("_", S7::prop(x, "modulo"))
    
    update_parameter(
        x = x,
        param = "tiempo",
        update_list = update_list
    )
}

#' @rdname elegir_tiempo
#' @export
elegir_cuando_se_hizo_gasto <- function(x,
                                        trimestre = NULL,
                                        mes = NULL) {
    
    modulo <- S7::prop(x, "modulo")
    
    if (modulo == "ingreso") {
        cli::cli_abort(
            "Para consultas del modulo de {.strong {modulo}} usa 
            {.code elegir_cuando_se_hizo_recaudacion()} o {.code elegir_tiempo()}"
        )
    }
    
    elegir_tiempo(
        x = x,
        trimestre = trimestre,
        mes = mes
    )
}

#' @rdname elegir_tiempo
#' @export
elegir_cuando_se_hizo_recaudacion <- function(x,
                                        trimestre = NULL,
                                        mes = NULL) {
    
    modulo <- S7::prop(x, "modulo")
    
    if (modulo == "gasto") {
        cli::cli_abort(
            "Para consultas del modulo de {.strong {modulo}} usa 
            {.code elegir_cuando_se_hizo_gasto()} o {.code elegir_tiempo()}"
        )
    }
    
    elegir_tiempo(
        x = x,
        trimestre = trimestre,
        mes = mes
    )
}
