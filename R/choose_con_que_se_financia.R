#' Definir la sección '¿Con qué se financian los gastos?'
#'
#' @inheritParams consultar
#' @param fuente_financiamiento int. Código de fuente de financiamiento.
#' En su versión más reciente va del 1 al 5.
#' @param rubro chr. código de rubro, de  forma "XX" (2).
#' @param tipo_de_recurso chr, Código de tipo de recurso.
#' No tiene forma estandar, puede ser de uno o dos caracteres, que pueden
#' ser letras o números.
#'
#' @return Una lista con nombres correspondientes a los endpoints de la API
#' @export
choose_con_que_se_financia <- function(x,
                                       fuente_financiamiento = NULL,
                                       rubro = NULL,
                                       tipo_de_recurso = NULL) {
    UseMethod("choose_con_que_se_financia")
}

#' @export
choose_con_que_se_financia.sep_df <- function(x,
                                              fuente_financiamiento = NULL,
                                              rubro = NULL,
                                              tipo_de_recurso = NULL) {
    query <- get_query(x)


    new_query <- set_con_que_se_financia(
        fuente_financiamiento = fuente_financiamiento,
        rubro = rubro,
        tipo_de_recurso = tipo_de_recurso
    )

    query <- purrr::list_modify(query, con_que_se_financia = new_query)
    attr(x, "query") <- query
    x
}

