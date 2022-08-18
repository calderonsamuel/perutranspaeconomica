#' Definir la seccion de '¿Cuándo se hizo el gasto?'
#'
#' @param trimestre int. Número del 1 al 4
#' @param mes int. Número del 1 al 12
#'
#' @return Una lista con nombres correspondientes a los endpoints de la API
#'
set_cuando_se_hizo_gasto <- function(trimestre = NULL, mes = NULL) {
    list(
        trimestre = trimestre,
        mes = mes
    ) |>
        purrr::discard(is.null)
}
