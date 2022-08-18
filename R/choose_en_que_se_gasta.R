#' @export
choose_en_que_se_gasta <- function(x,
                                   categoria_presupuestal = NULL,
                                   producto = NULL,
                                   actividad = NULL,
                                   funcion = NULL,
                                   division_funcional = NULL,
                                   grupo_funcional = NULL,
                                   meta = NULL) {
    UseMethod("choose_en_que_se_gasta")
}

#' @export
choose_en_que_se_gasta.sep_df <- function(x,
                                          categoria_presupuestal = NULL,
                                          producto = NULL,
                                          actividad = NULL,
                                          funcion = NULL,
                                          division_funcional = NULL,
                                          grupo_funcional = NULL,
                                          meta = NULL) {
    query <- get_query(x)


    new_query <- set_en_que_se_gasta(
        categoria_presupuestal = categoria_presupuestal,
        producto = producto,
        actividad = actividad,
        funcion = funcion,
        division_funcional = division_funcional,
        grupo_funcional = grupo_funcional,
        meta = meta
    )

    query <- purrr::list_modify(query, en_que_se_gasta = new_query)
    attr(x, "query") <- query
    x
}
