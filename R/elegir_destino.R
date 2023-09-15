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
