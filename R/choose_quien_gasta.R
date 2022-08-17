#' @export
choose_quien_gasta <- function(x,
                               nivel = NULL,
                               sector = NULL,
                               pliego = NULL,
                               unidad_ejecutora = NULL,
                               goblocal_o_manc = NULL,
                               mancomunidad = NULL,
                               departamento = NULL,
                               provincia = NULL,
                               municipalidad = NULL) {
    UseMethod("choose_quien_gasta")
}

#' @export
choose_quien_gasta.sep_df <- function(x,
                                      nivel = NULL,
                                      sector = NULL,
                                      pliego = NULL,
                                      unidad_ejecutora = NULL,
                                      goblocal_o_manc = NULL,
                                      mancomunidad = NULL,
                                      departamento = NULL,
                                      provincia = NULL,
                                      municipalidad = NULL) {
    query <- get_query(x)


    new_query <- set_quien_gasta(
            nivel = nivel, sector = sector,
            pliego = pliego,
            unidad_ejecutora = unidad_ejecutora,
            goblocal_o_manc = goblocal_o_manc,
            mancomunidad = mancomunidad,
            departamento = departamento,
            provincia = provincia,
            municipalidad = municipalidad
        )

    query <- purrr::list_modify(query, new_query)
    attr(x, "query") <- query
    x
}
