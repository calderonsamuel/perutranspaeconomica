#' @export
choose_donde_se_gasta <- function(x,
                                  departamento_meta = NULL) {
    UseMethod("choose_donde_se_gasta")
}

#' @export
choose_donde_se_gasta.sep_df <- function(x,
                                         departamento_meta = NULL) {
    query <- get_query(x)


    new_query <- set_donde_se_gasta(
        departamento_meta = departamento_meta
    )

    query <- purrr::list_modify(query, donde_se_gasta = new_query)
    attr(x, "query") <- query
    x
}
