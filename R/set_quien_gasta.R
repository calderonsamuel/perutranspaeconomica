#' @inheritParams choose_quien_gasta
set_quien_gasta <- function(nivel = NULL,
                            sector = NULL,
                            pliego = NULL,
                            unidad_ejecutora = NULL,
                            goblocal_o_manc = NULL,
                            mancomunidad = NULL,
                            departamento = NULL,
                            provincia = NULL,
                            municipalidad = NULL
) {

    list(
        nivel = nivel,
        sector = sector,
        pliego = pliego,
        unidad_ejecutora = unidad_ejecutora,
        goblocal_o_manc = goblocal_o_manc,
        mancomunidad = mancomunidad,
        departamento = departamento,
        provincia = provincia,
        municipalidad = municipalidad
    ) |>
        purrr::discard(is.null)
}
