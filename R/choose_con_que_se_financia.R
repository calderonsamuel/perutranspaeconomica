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

