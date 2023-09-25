params_for_query <- function() {
    list(
        periodo = list(param_name = "y", print_name = "Periodo anual"),
        nivel_gasto = list(param_name = "1", print_name = "Nivel de gobierno"),
        nivel_ingreso = list(param_name = "1", print_name = "Nivel de gobierno"),
        sector_gasto = list(param_name = "2", print_name = "Sector"),
        sector_ingreso = list(param_name = "2", print_name = "Sector"),
        pliego_gasto = list(param_name = "3", print_name = "Pliego"),
        pliego_ingreso = list(param_name = "3", print_name = "Pliego"),
        unidad_ejecutora_gasto = list(param_name = "4", print_name = "Unidad Ejecutora"),
        unidad_ejecutora_ingreso = list(param_name = "4", print_name = "Unidad Ejecutora"),
        departamento_gasto = list(param_name = "5", print_name = "Departamento"),
        departamento_ingreso = list(param_name = "5", print_name = "Departamento"),
        provincia_gasto = list(param_name = "6", print_name = "Provincia"),
        provincia_ingreso = list(param_name = "6", print_name = "Provincia"),
        municipalidad_gasto = list(param_name = "7", print_name = "Municipalidad"),
        municipalidad_ingreso = list(param_name = "7", print_name = "Municipalidad"),
        goblocal_o_manc_gasto = list(param_name = "37", print_name = "Gobierno local o mancomunidad"),
        goblocal_o_manc_ingreso = list(param_name = "23", print_name = "Gobierno local o mancomunidad"),
        mancomunidad_gasto = list(param_name = "36", print_name = "Mancomunidad"),
        mancomunidad_ingreso = list(param_name = "24", print_name = "Mancomunidad"),
        generica_gasto = list(param_name = "24", print_name = "Generica"),
        generica_ingreso = list(param_name = "18", print_name = "Generica"),
        subgenerica_gasto = list(param_name = "25", print_name = "Sub-generica"),
        subgenerica_ingreso = list(param_name = "19", print_name = "Sub-generica"),
        detalle_subgenerica_gasto = list(param_name = "26", print_name = "Detalle de sub-generica"),
        detalle_subgenerica_ingreso = list(param_name = "20", print_name = "Detalle de sub-generica"),
        especifica_gasto = list(param_name = "27", print_name = "Especifica"),
        especifica_ingreso = list(param_name = "21", print_name = "Especifica"),
        detalle_especifica_gasto = list(param_name = "28", print_name = "Detalle de especifica"),
        detalle_especifica_ingreso = list(param_name = "22", print_name = "Detalle de especifica"),
        fuente_financiamiento_gasto = list(param_name = "14", print_name = "Fuente de financiamiento"),
        fuente_financiamiento_ingreso = list(param_name = "8", print_name = "Fuente de financiamiento"),
        rubro_gasto = list(param_name = "15", print_name = "Rubro"),
        rubro_ingreso = list(param_name = "9", print_name = "Rubro"),
        tipo_de_recurso_gasto = list(param_name = "17", print_name = "Tipo de recurso"),
        tipo_de_recurso_ingreso = list(param_name = "11", print_name = "Tipo de recurso"),
        departamento_meta = list(param_name = "21", print_name = "Departamento (meta)"),
        categoria_presupuestal = list(param_name = "30", print_name = "Categoria Presupuestal"),
        producto = list(param_name = "31", print_name = "Producto"),
        actividad = list(param_name = "32", print_name = "Actividad"),
        meta = list(param_name = "13", print_name = "Meta"),
        funcion = list(param_name = "8", print_name = "Funcion"),
        division_funcional = list(param_name = "33", print_name = "Division Funcional"),
        grupo_funcional = list(param_name = "34", print_name = "Grupo Funcional"),
        trimestre_gasto = list(param_name = "22", print_name = "Trimestre"),
        trimestre_ingreso = list(param_name = "16", print_name = "Trimestre"),
        mes_gasto = list(param_name = "23", print_name = "Mes"),
        mes_ingreso = list(param_name = "17", print_name = "Mes")
    )
}

translate_params_list <- function(params_list_from_query) {
    all_params <- params_for_query()
    params_names <- names(params_list_from_query) %>% 
        purrr::map_chr(~all_params[[.x]][["param_name"]])
    
    params_list_from_query %>% 
        purrr::map(~ifelse(.x == "todos", "", .x)) %>%
        stats::setNames(params_names)
}
