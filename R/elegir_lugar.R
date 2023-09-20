#' Elegir lugar de uso del presupuesto
#' 
#' Estas funciones permiten desglosar la busqueda de acuerdo
#' al lugar de uso del presupuesto.
#'
#' @inheritParams consultar
#' @param departamento_meta chr. Código de departamento.
#' Para obtener "Callao" usar "07", y para obtener 'Exterior' usar "98".
#'
#' @return Un data.frame con clase <transpaeco>
#' @export
elegir_lugar <- function(x, departamento_meta = NULL) {
    
    update_parameter(
        x = x,
        param = "lugar",
        update_list = list(
            departamento_meta = departamento_meta
        )
    )
}

#' @rdname elegir_lugar
#' @export
elegir_donde_se_gasta <- function(x, departamento_meta = NULL) {
    elegir_lugar(x = x, departamento_meta = departamento_meta)
}
