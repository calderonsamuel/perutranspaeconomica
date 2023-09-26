#' Elegir destino de uso del presupuesto.
#' 
#' Estas funciones permiten desglosar la busqueda de acuerdo al destino
#' de uso del presupuesto. Debido a que solo se pueden usar en el módulo de gasto, 
#' ambas tienen el mismo comportamiento.
#'
#' @inheritParams consultar
#' @param categoria_presupuestal chr. Código de programa presupuestal de forma "XXXX" (4).
#' Para Acciones Centrales usar "9001" y para APnoP usar "9002".
#' @param producto chr. Código de producto o proyecto de inversión de forma "XXXXXXX" (7).
#' @param actividad chr. Código de actividad, acción de inversión u obra, de forma "XXXXXXX" (7).
#' @param funcion chr. Código de función de forma "XX" (2).
#' @param division_funcional chr. Código de división funcional de forma "XXX" (3).
#' @param grupo_funcional chr. Código de grupo funcional de forma "XXXX" (4).
#' @param meta chr. Código de meta. No tiene forma estandarizada.
#'
#' @inherit iniciar_transparencia_economica return
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
