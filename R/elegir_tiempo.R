#' Definir la seccion de '¿Cuándo se hizo el gasto?'
#'
#' @inheritParams consultar
#' @param trimestre int. Número del 1 al 4
#' @param mes int. Número del 1 al 12
#'
#' @return Un data.frame con clase <transpaeco>
#' @export
elegir_tiempo <- function(x,
                          trimestre = NULL,
                          mes = NULL) {
    
    update_parameter(
        x = x,
        param = "tiempo",
        update_list = list(
            trimestre = trimestre,
            mes = mes
        )
    )
}

#' @rdname elegir_tiempo
#' @export
elegir_cuando_se_hizo_gasto <- function(x,
                                        trimestre = NULL,
                                        mes = NULL) {
    elegir_tiempo(
        x = x,
        trimestre = trimestre,
        mes = mes
    )
}
