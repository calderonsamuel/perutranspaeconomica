#' Elegir el origen del presupuesto
#' 
#' Estas funciones permiten desglosar la busqueda de acuerdo al origen 
#' del financiamiento del presupuesto.
#'
#' @inheritParams consultar
#' @param fuente_financiamiento int. Código de fuente de financiamiento.
#' En su versión más reciente va del 1 al 5.
#' @param rubro chr. código de rubro, de  forma "XX" (2).
#' @param tipo_de_recurso chr, Código de tipo de recurso.
#' No tiene forma estandar, puede ser de uno o dos caracteres, que pueden
#' ser letras o números.
#'
#' @return Un data.frame con clase <transpaeco>
#' @export
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
    elegir_origen(
        x = x,
        fuente_financiamiento = fuente_financiamiento,
        rubro = rubro,
        tipo_de_recurso = tipo_de_recurso
    )
}
