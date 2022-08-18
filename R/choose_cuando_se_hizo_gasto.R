#' @export
choose_cuando_se_hizo_gasto <- function(x,
                                        trimestre = NULL,
                                        mes = NULL) {
    UseMethod("choose_cuando_se_hizo_gasto")
}

#' @export
choose_cuando_se_hizo_gasto.sep_df <- function(x,
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
