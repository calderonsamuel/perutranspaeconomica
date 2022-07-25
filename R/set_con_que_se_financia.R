#' Definir la sección '¿Con qué se financian los gastos?'
#'
#' @param fuente_financiamiento int. Código de fuente de financiamiento.
#' En su versión más reciente va del 1 al 5.
#' @param rubro chr. código de rubro, de  forma "XX" (2).
#' @param tipo_de_recurso chr, Código de tipo de recurso.
#' No tiene forma estandar, puede ser de uno o dos caracteres, que pueden
#' ser letras o números.
#'
#' @return Una lista con nombres correspondientes a los endpoints de la API
#'
set_con_que_se_financia <- function(fuente_financiamiento = NULL,
                                    rubro = NULL,
                                    tipo_de_recurso = NULL
                                    ) {
    params <- list(
        "14" = fuente_financiamiento,
        "15" = rubro,
        "17" = tipo_de_recurso
    )

    purrr::discard(params, is.null)
}
