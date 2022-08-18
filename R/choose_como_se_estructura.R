#' @export
choose_como_se_estructura <- function(x,
                                      generica = NULL,
                                      subgenerica = NULL,
                                      detalle_subgenerica = NULL,
                                      especifica = NULL,
                                      detalle_especifica = NULL) {
    UseMethod("choose_como_se_estructura")
}

#' @export
choose_como_se_estructura.sep_df <- function(x,
                                             generica = NULL,
                                             subgenerica = NULL,
                                             detalle_subgenerica = NULL,
                                             especifica = NULL,
                                             detalle_especifica = NULL) {
    query <- get_query(x)


    new_query <- set_como_se_estructura(
        generica = generica,
        subgenerica = subgenerica,
        detalle_subgenerica = detalle_subgenerica,
        especifica = especifica,
        detalle_especifica = detalle_especifica
    )

    query <- purrr::list_modify(query, como_se_estructura = new_query)
    attr(x, "query") <- query
    x
}
