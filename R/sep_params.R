params_for_query <- function() {
    list(
        periodo = list(param_name = "y", print_name = "Periodo anual"),
        nivel = list(param_name = "1", print_name = "Nivel de gobierno"),
        sector = list(param_name = "2", print_name = "Sector"),
        pliego = list(param_name = "3", print_name = "Pliego"),
        unidad_ejecutora = list(param_name = "4", print_name = "Unidad Ejecutora"),
        departamento = list(param_name = "5", print_name = "Departamento"),
        provincia = list(param_name = "6", print_name = "Provincia"),
        municipalidad = list(param_name = "7", print_name = "Municipalidad"),
        goblocal_o_manc = list(param_name = "37", print_name = "Gobierno local o mancomunidad"),
        mancomunidad = list(param_name = "36", print_name = "Mancomunidad"),
        generica = list(param_name = "24", print_name = "Generica"),
        subgenerica = list(param_name = "25", print_name = "Sub-generica"),
        detalle_subgenerica = list(param_name = "26", print_name = "Detalle de sub-generica"),
        especifica = list(param_name = "27", print_name = "Especifica"),
        detalle_especifica = list(param_name = "28", print_name = "Detalle de especifica"),
        fuente_financiamiento = list(param_name = "14", print_name = "Fuente de financiamiento"),
        rubro = list(param_name = "15", print_name = "Rubro"),
        tipo_de_recurso = list(param_name = "17", print_name = "Tipo de recurso"),
        departamento_meta = list(param_name = "21", print_name = "Departamento (meta)"),
        categoria_presupuestal = list(param_name = "30", print_name = "Categoria Presupuestal"),
        producto = list(param_name = "31", print_name = "Producto"),
        actividad = list(param_name = "32", print_name = "Actividad"),
        meta = list(param_name = "13", print_name = "Meta"),
        funcion = list(param_name = "8", print_name = "Funcion"),
        division_funcional = list(param_name = "33", print_name = "Division Funcional"),
        grupo_funcional = list(param_name = "34", print_name = "Grupo Funcional"),
        trimestre = list(param_name = "22", print_name = "Trimestre"),
        mes = list(param_name = "23", print_name = "Mes")
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
