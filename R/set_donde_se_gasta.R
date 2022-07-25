#' Definir la seccion de '¿Dónde se gasta?'
#'
#' @param departamento_meta chr. Código de departamento.
#' Para obtener "Callao" usar "07", y para obtener 'Exterior' usar "98".
#'
#' @return Una lista con nombres correspondientes a los endpoints de la API
#'
set_donde_se_gasta <- function(departamento_meta = NULL) {
    params <- list("21" = departamento_meta)
    purrr::discard(params, is.null)
}
