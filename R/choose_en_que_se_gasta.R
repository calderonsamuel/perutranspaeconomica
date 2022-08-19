#' Definir la seccion de '¿En qué se gasta?'
#'
#' @inheritParams consultar
#' @param categoria_presupuestal chr. Código de programa presupuestal de forma "XXXX" (4).
#' Para Acciones Centrales usar "9001" y para APnoP usar "9002".
#' @param producto chr. Código de producto o proyecto de inversión de forma "XXXXXXX" (7).
#' @param actividad chr. Código de actividad, acción de inversión u obra, de forma "XXXXXXX" (7).
#' @param funcion chr. Código de función de forma "XX" (2).
#' @param division_funcional chr. Código de división funcional de forma "XXX" (3).
#' @param grupo_funcional chr. Código de grupo funcional de forma "XXXX" (4).
#' @param meta chr. Código de meta. No tiene forma estandarizada.
#'
#' @return Una lista con nombres correspondientes a los endpoints de la API
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
