#' @inheritParams choose_como_se_estructura
#'
set_como_se_estructura <- function(generica = NULL,
                                   subgenerica = NULL,
                                   detalle_subgenerica = NULL,
                                   especifica = NULL,
                                   detalle_especifica = NULL
                                   ) {
    params <- list(
        generica = generica,
        subgenerica = subgenerica,
        detalle_subgenerica = detalle_subgenerica,
        especifica = especifica,
        detalle_especifica = detalle_especifica
    )

    purrr::discard(params, is.null)
}
