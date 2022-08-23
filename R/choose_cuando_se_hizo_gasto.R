#' Definir la seccion de '¿Cuándo se hizo el gasto?'
#'
#' @inheritParams consultar
#' @param trimestre int. Número del 1 al 4
#' @param mes int. Número del 1 al 12
#'
#' @return Una lista con nombres correspondientes a los endpoints de la API
#' @export
elegir_cuando_se_hizo_gasto <- function(x,
                                        trimestre = NULL,
                                        mes = NULL) {
    UseMethod("elegir_cuando_se_hizo_gasto")
}

#' @export
elegir_cuando_se_hizo_gasto.sep_df <- function(x,
                                               trimestre = NULL,
                                               mes = NULL) {
    query <- get_query(x)


    new_query <- set_cuando_se_hizo_gasto(
        trimestre = trimestre,
        mes = mes
    )

    query <- purrr::list_modify(query, cuando_se_hizo_gasto = new_query)
    attr(x, "query") <- query
    x
}
