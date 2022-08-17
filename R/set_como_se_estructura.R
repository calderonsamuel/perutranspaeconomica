#' Definir la seccion de '¿Cómo se estructura el gasto?'
#'
#' Estos endpoints se construyen secuencialmente en base a los valores de generica.
#'
#' Para escribir el código de genérica se debe alterar un poco la representación típica.
#' Por ejemplo, la genérica "7-28" debe pasarse a `generica` como "7-2-8".
#'
#' A partir del nivel `subgenerica` debe omitirse solo el primer dígito de la genérica.
#' Por ejemplo, la sub-genérica "7-28.2" debe pasarse como "2-8-2" y para el
#' detalle de la sub-genérica "7-28.2.1" debe pasarse "2-8-2-1". La específica y
#' detalle de específica siguen este patrón.
#'
#'
#' @param generica chr. Código de genérica de forma "X-X-X"
#' @param subgenerica chr. Código de sub-genérica de forma "X-X-X"
#' @param detalle_subgenerica chr. Código de detalle de sub-genérica de forma "X-X-X-X"
#' @param especifica chr. Código de específica de forma "X-X-X-X-X"
#' @param detalle_especifica chr. Código de detalle de específica de forma "X-X-X-X-X-X"
#'
#' @return Una lista con nombres correspondientes a los endpoints de la API
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
