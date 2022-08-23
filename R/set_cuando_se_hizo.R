
#' @inheritParams elegir_cuando_se_hizo_gasto
set_cuando_se_hizo_gasto <- function(trimestre = NULL, mes = NULL) {
    list(
        trimestre = trimestre,
        mes = mes
    ) |>
        purrr::discard(is.null)
}
