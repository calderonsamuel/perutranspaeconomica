#' Elegir la estructura con la que se usa el presupuesto
#'
#' Estas funciones permiten desglosar la busqueda de acuerdo a valores de estructura presupuestal.
#' `elegir_como_se_estructura_gasto()` y `elegir_como_se_estructura_recaudacion()` sirven los módulos de gasto e ingresos, respectivamente.
#' `elegir_estructura()` es una versión agnóstica que sirve para ámbos módulos.
#' 
#' Estos endpoints se construyen secuencialmente en base a los valores de generica.
#'
#' Para escribir el código de genérica se debe alterar un poco la representación típica.
#' Por ejemplo, la genérica "7-28" debe pasarse a `generica` como "7-2-8".
#'
#' A partir del nivel `subgenerica` debe omitirse solo el primer dígito de la genérica.
#' Por ejemplo, la sub-genérica "7-28.2" debe pasarse como "2-8-2" y para el
#' detalle de la sub-genérica "7-28.2.1" debe pasarse "2-8-2-1". La específica y
#' detalle de específica siguen este patrón.
#'
#' @inheritParams consultar
#' @param generica chr. Código de genérica de forma "X-X-X"
#' @param subgenerica chr. Código de sub-genérica de forma "X-X-X"
#' @param detalle_subgenerica chr. Código de detalle de sub-genérica de forma "X-X-X-X"
#' @param especifica chr. Código de específica de forma "X-X-X-X-X"
#' @param detalle_especifica chr. Código de detalle de específica de forma "X-X-X-X-X-X"
#'
#' @inherit iniciar_transparencia_economica return
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
