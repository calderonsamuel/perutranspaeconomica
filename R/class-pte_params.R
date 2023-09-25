pte_params <- S7::new_class(
    name = "pte_params",
    properties = list(
        periodo_anual = S7::new_property(
            class = S7::class_list,
            default = list(
                periodo = NULL
            )
        ),
        institucion = S7::new_property(
            class = S7::class_list,
            default = list(
                nivel_gasto = NULL,
                sector_gasto = NULL,
                pliego_gasto = NULL,
                unidad_ejecutora_gasto = NULL,
                goblocal_o_manc_gasto = NULL,
                mancomunidad_gasto = NULL,
                departamento_gasto = NULL,
                provincia_gasto = NULL,
                municipalidad_gasto = NULL,
                nivel_ingreso = NULL,
                sector_ingreso = NULL,
                pliego_ingreso = NULL,
                unidad_ejecutora_ingreso = NULL,
                goblocal_o_manc_ingreso = NULL,
                mancomunidad_ingreso = NULL,
                departamento_ingreso = NULL,
                provincia_ingreso = NULL,
                municipalidad_ingreso = NULL
            )
        ),
        destino = S7::new_property(
            class = S7::class_list,
            default = list(
                categoria_presupuestal = NULL,
                producto = NULL,
                actividad = NULL,
                funcion = NULL,
                division_funcional = NULL,
                grupo_funcional = NULL,
                meta = NULL
            )
        ),
        origen = S7::new_property(
            class = S7::class_list,
            default = list(
                fuente_financiamiento_gasto = NULL,
                rubro_gasto = NULL,
                tipo_de_recurso_gasto = NULL,
                fuente_financiamiento_ingreso = NULL,
                rubro_ingreso = NULL,
                tipo_de_recurso_ingreso = NULL
            )
        ),
        estructura = S7::new_property(
            class = S7::class_list,
            default = list(
                generica_gasto = NULL,
                subgenerica_gasto = NULL,
                detalle_subgenerica_gasto = NULL,
                especifica_gasto = NULL,
                detalle_especifica_gasto = NULL,
                generica_ingreso  = NULL,
                subgenerica_ingreso  = NULL,
                detalle_subgenerica_ingreso  = NULL,
                especifica_ingreso  = NULL,
                detalle_especifica_ingreso  = NULL
            )
        ),
        lugar = S7::new_property(
            class = S7::class_list,
            default = list(
                departamento_meta  = NULL
            )
        ),
        tiempo = S7::new_property(
            class = S7::class_list,
            default = list(
                trimestre_gasto = NULL,
                mes_gasto = NULL,
                trimestre_ingreso = NULL,
                mes_ingreso = NULL
            )
        )
    )
)

update_single_prop <- S7::new_generic("update_single_prop", "x")

S7::method(update_single_prop, pte_params) <- function(x, param, prop, value) {
    param_content <- S7::prop(x, param)
    
    if (! prop %in% names(param_content)) {
        cli::cli_abort("{.str {prop}} no es una propiedad de {.code {param}}")
    }
    
    if (sum(value == "todos") > 1) {
        cli::cli_abort("{.str todos} debe aparecer solo una vez en {.code {prop}}")
    }
    
    param_content[[prop]] <- value
    S7::prop(x, param) <- param_content
    
    x
}
