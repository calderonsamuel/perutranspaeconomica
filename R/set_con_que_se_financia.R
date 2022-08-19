
#' @inheritParams choose_con_que_se_financia
set_con_que_se_financia <- function(fuente_financiamiento = NULL,
                                    rubro = NULL,
                                    tipo_de_recurso = NULL
                                    ) {
    list(
        fuente_financiamiento = fuente_financiamiento,
        rubro = rubro,
        tipo_de_recurso = tipo_de_recurso
    ) |>
        purrr::discard(is.null)
}
