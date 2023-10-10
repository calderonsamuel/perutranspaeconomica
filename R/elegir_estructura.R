#' Elegir la estructura con la que se usa el presupuesto
#'
#' Estas funciones permiten desglosar la busqueda de acuerdo a valores de estructura presupuestal.
#' `elegir_como_se_estructura_gasto()` y `elegir_como_se_estructura_recaudacion()` 
#' sirven para los módulos de gasto e ingresos, respectivamente.
#' `elegir_estructura()` es una versión agnóstica que sirve para ámbos módulos. 
#' Ver Detalles para entender la conformacion del formato de consulta de cada parametro.
#' 
#' Estos endpoints se construyen secuencialmente en base a los valores de genérica.
#'
#' Para escribir el código de genérica se debe alterar un poco la representación típica.
#' Por ejemplo, la genérica de *gasto* "7-28" debe pasarse a `generica` como "7-2-8".
#'
#' A partir del nivel `subgenerica` debe omitirse solo el primer dígito de la genérica.
#' Por ejemplo, la sub-genérica "7-28.2" debe pasarse como "2-8-2" y para el
#' detalle de la sub-genérica "7-28.2.1" debe pasarse "2-8-2-1". La específica y
#' detalle de específica siguen este patrón.
#' 
#' Estas funciones aplicarán una validación de  la forma para cada argumento 
#' mediante expresiones regulares. Sumado a ello, se aplica una validación 
#' para evitar valores anómalos.
#'
#' @inheritParams consultar
#' @param generica chr. Código de genérica. En módulo de *gasto* debe tener la forma "0-0-0" 
#' y en módulo de *ingreso* debe tener la forma "0-0".
#' @param subgenerica chr. Código de sub-genérica de forma "0-0-0"
#' @param detalle_subgenerica chr. Código de detalle de sub-genérica de forma "0-0-0-0"
#' @param especifica chr. Código de específica de forma "0-0-0-0-0"
#' @param detalle_especifica chr. Código de detalle de específica de forma "0-0-0-0-0-0"
#'
#' @inherit iniciar_transparencia_economica return
#' @export
#' @examples
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_como_se_estructura_gasto(generica = "todos") 
#' 
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_como_se_estructura_gasto(generica = "todos") %>%
#'     consultar()
#' 
#' # notese la forma de `generica`
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_como_se_estructura_gasto(
#'         generica = "5-2-0", 
#'         subgenerica = "todos"
#'     ) 
#' 
#' # cuando no se respeta la forma, el mensaje de error 
#' # muestra la expresion regular esperada
#' tryCatch({
#'     iniciar_transparencia_economica(modulo = "gasto") %>%
#'         elegir_periodo_anual(2022) %>%
#'         elegir_como_se_estructura_gasto(
#'             generica = "5-20", 
#'             subgenerica = "todos"
#'         ) 
#' }, error = function(e) print(e))

elegir_estructura <- function(x,
                              generica = NULL,
                              subgenerica = NULL,
                              detalle_subgenerica = NULL,
                              especifica = NULL,
                              detalle_especifica = NULL) {
    
    update_list <- list(
        generica = generica,
        subgenerica = subgenerica,
        detalle_subgenerica = detalle_subgenerica,
        especifica = especifica,
        detalle_especifica = detalle_especifica
    )
    
    names(update_list) <- names(update_list) %>%
        paste0("_", S7::prop(x, "modulo"))
    
    update_parameter(
        x = x,
        param = "estructura",
        update_list = update_list
    )
}

#' @rdname elegir_estructura
#' @export
elegir_como_se_estructura_gasto <- function(x,
                                      generica = NULL,
                                      subgenerica = NULL,
                                      detalle_subgenerica = NULL,
                                      especifica = NULL,
                                      detalle_especifica = NULL) {
    
    modulo <- S7::prop(x, "modulo")
    
    if (modulo == "ingreso") {
        cli::cli_abort(
            "Para consultas del modulo de {.strong {modulo}} usa 
            {.code elegir_como_se_estructura_recaudacion()} o {.code elegir_estructura()}"
        )
    }
    
    elegir_estructura(
        x = x,
        generica = generica,
        subgenerica = subgenerica,
        detalle_subgenerica = detalle_subgenerica,
        especifica = especifica,
        detalle_especifica = detalle_especifica
    )
}

#' @rdname elegir_estructura
#' @export
elegir_como_se_estructura_recaudacion <- function(x,
                                      generica = NULL,
                                      subgenerica = NULL,
                                      detalle_subgenerica = NULL,
                                      especifica = NULL,
                                      detalle_especifica = NULL) {
    
    modulo <- S7::prop(x, "modulo")
    
    if (modulo == "gasto") {
        cli::cli_abort(
            "Para consultas del modulo de {.strong {modulo}} usa 
            {.code elegir_como_se_estructura_gasto()} o {.code elegir_estructura()}"
        )
    }
    
    elegir_estructura(
        x = x,
        generica = generica,
        subgenerica = subgenerica,
        detalle_subgenerica = detalle_subgenerica,
        especifica = especifica,
        detalle_especifica = detalle_especifica
    )
}
