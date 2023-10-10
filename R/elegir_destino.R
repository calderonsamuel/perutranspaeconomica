#' Elegir destino de uso del presupuesto.
#' 
#' Estas funciones permiten desglosar la busqueda de acuerdo al destino
#' de uso del presupuesto. Debido a que solo se pueden usar en el módulo de gasto, 
#' ambas tienen el mismo comportamiento.
#'
#' @inheritParams consultar
#' @param categoria_presupuestal chr. Código de programa presupuestal de forma "0000" (4 digitos).
#' Para Acciones Centrales usar "9001" y para APnoP usar "9002".
#' @param producto chr. Código de producto o proyecto de inversión de forma "0000000" (7 digitos).
#' @param actividad chr. Código de actividad, acción de inversión u obra, de forma "0000000" (7 digitos).
#' @param funcion chr. Código de función de forma "00" (2 digitos).
#' @param division_funcional chr. Código de división funcional de forma "000" (3 digitos).
#' @param grupo_funcional chr. Código de grupo funcional de forma "0000" (4 digitos).
#' @param meta chr. Código de meta. No tiene forma estandarizada y no es obtenerla a partir de la información provista.
#' Es el parametro de consulta mas problematico.
#'
#' @inherit iniciar_transparencia_economica return
#' @export
#' @examples
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_en_que_se_gasta(categoria_presupuestal = "todos")
#' 
#' iniciar_transparencia_economica(modulo = "gasto") %>%
#'     elegir_periodo_anual(2022) %>%
#'     elegir_en_que_se_gasta(categoria_presupuestal = "todos") %>%
#'     consultar()
#' 
elegir_destino <- function(x,
                           categoria_presupuestal = NULL,
                           producto = NULL,
                           actividad = NULL,
                           funcion = NULL,
                           division_funcional = NULL,
                           grupo_funcional = NULL,
                           meta = NULL) {
    update_parameter(
        x = x,
        param = "destino",
        update_list = list(
            categoria_presupuestal = categoria_presupuestal,
            producto = producto,
            actividad = actividad,
            funcion = funcion,
            division_funcional = division_funcional,
            grupo_funcional = grupo_funcional,
            meta = meta
        )
    )
}

#' @rdname elegir_destino
#' @export
elegir_en_que_se_gasta <- function(x,
                                   categoria_presupuestal = NULL,
                                   producto = NULL,
                                   actividad = NULL,
                                   funcion = NULL,
                                   division_funcional = NULL,
                                   grupo_funcional = NULL,
                                   meta = NULL) {
    
    elegir_destino(
        x = x,
        categoria_presupuestal = categoria_presupuestal,
        producto = producto,
        actividad = actividad,
        funcion = funcion,
        division_funcional = division_funcional,
        grupo_funcional = grupo_funcional,
        meta = meta
    )
}
