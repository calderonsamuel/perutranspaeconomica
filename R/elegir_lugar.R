#' Elegir lugar de uso del presupuesto
#' 
#' Estas funciones permiten desglosar la busqueda de acuerdo
#' al lugar de uso del presupuesto. Debido a que solo se pueden usar en el 
#' módulo de gasto, ambas tienen el mismo comportamiento.
#'
#' @inheritParams consultar
#' @param departamento_meta chr. Código de departamento, de forma "00" (2 digitos).
#' Para obtener "Callao" usar "07", y para obtener 'Exterior' usar "98".
#'
#' @inherit iniciar_transparencia_economica return
#' @export
#' 
#' @examples
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_donde_se_gasta(
#'         departamento_meta = "todos"
#'     )
#' 
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_donde_se_gasta(
#'         departamento_meta = "todos"
#'     ) %>%
#'     consultar()
#' 
#' # cuando no se respeta la forma, el mensaje de error
#' # muestra la expresion regular esperada
#' tryCatch({
#'     iniciar_transparencia_economica(modulo = "gasto") %>%
#'         elegir_periodo_anual(2022) %>%
#'         elegir_donde_se_gasta(
#'             departamento_meta = "2-0"
#'         )
#' }, error = function(e) print(e))
#' 
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
