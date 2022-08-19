#' @inheritParams choose_en_que_se_gasta
set_en_que_se_gasta <- function(categoria_presupuestal = NULL,
                                producto = NULL,
                                actividad = NULL,
                                funcion = NULL,
                                division_funcional = NULL,
                                grupo_funcional = NULL,
                                meta = NULL
) {
    list(
        categoria_presupuestal = categoria_presupuestal,
        producto = producto,
        actividad = actividad,
        funcion = funcion,
        division_funcional = division_funcional,
        grupo_funcional = grupo_funcional,
        meta = meta
    ) |>
        purrr::discard(is.null)
}
