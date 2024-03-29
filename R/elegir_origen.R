#' Elegir el origen del presupuesto
#' 
#' Estas funciones permiten desglosar la busqueda de acuerdo al origen 
#' del financiamiento del presupuesto.
#' `elegir_con_que_se_financia()` y `elegir_fuentes_de_recaudacion()` sirven los módulos de gasto e ingresos, respectivamente.
#' `elegir_origen()` es una versión agnóstica que sirve para ámbos módulos.
#'
#' @inheritParams consultar
#' @param fuente_financiamiento int. Código de fuente de financiamiento.
#' En su versión más reciente va del 1 al 5.
#' @param rubro chr. código de rubro, de  forma "00" (2 digitos).
#' @param tipo_de_recurso chr, Código de tipo de recurso.
#' No tiene forma estandar, puede ser de una letra mayuscula, 
#' un digito, o dos digitos.
#'
#' @inherit iniciar_transparencia_economica return
#' @export
#' 
#' @examples
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_con_que_se_financia(
#'         rubro = "todos"
#'     )
#' 
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_con_que_se_financia(
#'         rubro = "todos"
#'     ) %>%
#'     consultar()
#' 
#' # desglose de tipo de recurso del rubro de "13: Donaciones y transferencias"
#' # notese la variacion en los codigos de tipo de recurso
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_con_que_se_financia(
#'         rubro = "13",
#'         tipo_de_recurso = "todos"
#'     ) %>%
#'     consultar()
#' 
#' # cuando no se respeta la forma, el mensaje de error
#' # muestra la expresion regular esperada
#' tryCatch({
#'     iniciar_transparencia_economica(modulo = "gasto") %>%
#'         elegir_periodo_anual(2022) %>%
#'         elegir_con_que_se_financia(
#'             rubro = "13",
#'             tipo_de_recurso = "AA"
#'         )
#' }, error = function(e) print(e))
#' 
elegir_origen <- function(x,
                          fuente_financiamiento = NULL,
                          rubro = NULL,
                          tipo_de_recurso = NULL) {
    
    update_list <- list(
        fuente_financiamiento = fuente_financiamiento,
        rubro = rubro,
        tipo_de_recurso = tipo_de_recurso
    )
    
    names(update_list) <- names(update_list) %>%
        paste0("_", S7::prop(x, "modulo"))
    
    update_parameter(
        x = x,
        param = "origen",
        update_list = update_list
    )
}

#' @rdname elegir_origen
#' @export
elegir_con_que_se_financia <- function(x,
                                       fuente_financiamiento = NULL,
                                       rubro = NULL,
                                       tipo_de_recurso = NULL) {
    
    modulo <- S7::prop(x, "modulo")
    
    if (modulo == "ingreso") {
        cli::cli_abort(
            "Para consultas del modulo de {.strong {modulo}} usa 
            {.code elegir_fuentes_de_recaudacion()} o {.code elegir_origen()}"
        )
    }
    
    elegir_origen(
        x = x,
        fuente_financiamiento = fuente_financiamiento,
        rubro = rubro,
        tipo_de_recurso = tipo_de_recurso
    )
}

#' @rdname elegir_origen
#' @export
elegir_fuentes_de_recaudacion <- function(x,
                                       fuente_financiamiento = NULL,
                                       rubro = NULL,
                                       tipo_de_recurso = NULL) {
    
    modulo <- S7::prop(x, "modulo")
    
    if (modulo == "gasto") {
        cli::cli_abort(
            "Para consultas del modulo de {.strong {modulo}} usa 
            {.code elegir_con_que_se_financia()} o {.code elegir_origen()}"
        )
    }
    
    elegir_origen(
        x = x,
        fuente_financiamiento = fuente_financiamiento,
        rubro = rubro,
        tipo_de_recurso = tipo_de_recurso
    )
}
