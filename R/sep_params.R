params_for_query <- function() {
    list(
        periodo = list(
            param_name = "y",
            print_name = "Periodo anual",
            regex = ".*"
        ),
        nivel_gasto = list(
            param_name = "1",
            print_name = "Nivel de gobierno",
            regex = ".*"
        ),
        nivel_ingreso = list(
            param_name = "1",
            print_name = "Nivel de gobierno",
            regex = ".*"
        ),
        sector_gasto = list(
            param_name = "2",
            print_name = "Sector",
            regex = ".*"
        ),
        sector_ingreso = list(
            param_name = "2",
            print_name = "Sector",
            regex = ".*"
        ),
        pliego_gasto = list(
            param_name = "3",
            print_name = "Pliego",
            regex = ".*"
        ),
        pliego_ingreso = list(
            param_name = "3",
            print_name = "Pliego",
            regex = ".*"
        ),
        unidad_ejecutora_gasto = list(
            param_name = "4",
            print_name = "Unidad Ejecutora",
            regex = ".*"
        ),
        unidad_ejecutora_ingreso = list(
            param_name = "4",
            print_name = "Unidad Ejecutora",
            regex = ".*"
        ),
        departamento_gasto = list(
            param_name = "5",
            print_name = "Departamento",
            regex = ".*"
        ),
        departamento_ingreso = list(
            param_name = "5",
            print_name = "Departamento",
            regex = ".*"
        ),
        provincia_gasto = list(
            param_name = "6",
            print_name = "Provincia",
            regex = ".*"
        ),
        provincia_ingreso = list(
            param_name = "6",
            print_name = "Provincia",
            regex = ".*"
        ),
        municipalidad_gasto = list(
            param_name = "7",
            print_name = "Municipalidad",
            regex = ".*"
        ),
        municipalidad_ingreso = list(
            param_name = "7",
            print_name = "Municipalidad",
            regex = ".*"
        ),
        goblocal_o_manc_gasto = list(
            param_name = "37",
            print_name = "Gobierno local o mancomunidad",
            regex = ".*"
        ),
        goblocal_o_manc_ingreso = list(
            param_name = "23",
            print_name = "Gobierno local o mancomunidad",
            regex = ".*"
        ),
        mancomunidad_gasto = list(
            param_name = "36",
            print_name = "Mancomunidad",
            regex = ".*"
        ),
        mancomunidad_ingreso = list(
            param_name = "24",
            print_name = "Mancomunidad",
            regex = ".*"
        ),
        generica_gasto = list(
            param_name = "24",
            print_name = "Generica",
            regex = ".*"
        ),
        generica_ingreso = list(
            param_name = "18",
            print_name = "Generica",
            regex = ".*"
        ),
        subgenerica_gasto = list(
            param_name = "25",
            print_name = "Sub-generica",
            regex = ".*"
        ),
        subgenerica_ingreso = list(
            param_name = "19",
            print_name = "Sub-generica",
            regex = ".*"
        ),
        detalle_subgenerica_gasto = list(
            param_name = "26",
            print_name = "Detalle de sub-generica",
            regex = ".*"
        ),
        detalle_subgenerica_ingreso = list(
            param_name = "20",
            print_name = "Detalle de sub-generica",
            regex = ".*"
        ),
        especifica_gasto = list(
            param_name = "27",
            print_name = "Especifica",
            regex = ".*"
        ),
        especifica_ingreso = list(
            param_name = "21",
            print_name = "Especifica",
            regex = ".*"
        ),
        detalle_especifica_gasto = list(
            param_name = "28",
            print_name = "Detalle de especifica",
            regex = ".*"
        ),
        detalle_especifica_ingreso = list(
            param_name = "22",
            print_name = "Detalle de especifica",
            regex = ".*"
        ),
        fuente_financiamiento_gasto = list(
            param_name = "14",
            print_name = "Fuente de financiamiento",
            regex = ".*"
        ),
        fuente_financiamiento_ingreso = list(
            param_name = "8",
            print_name = "Fuente de financiamiento",
            regex = ".*"
        ),
        rubro_gasto = list(
            param_name = "15",
            print_name = "Rubro",
            regex = ".*"
        ),
        rubro_ingreso = list(
            param_name = "9",
            print_name = "Rubro",
            regex = ".*"
        ),
        tipo_de_recurso_gasto = list(
            param_name = "17",
            print_name = "Tipo de recurso",
            regex = ".*"
        ),
        tipo_de_recurso_ingreso = list(
            param_name = "11",
            print_name = "Tipo de recurso",
            regex = ".*"
        ),
        departamento_meta = list(
            param_name = "21",
            print_name = "Departamento (meta)",
            regex = ".*"
        ),
        categoria_presupuestal = list(
            param_name = "30",
            print_name = "Categoria Presupuestal",
            regex = ".*"
        ),
        producto = list(
            param_name = "31",
            print_name = "Producto",
            regex = ".*"
        ),
        actividad = list(
            param_name = "32",
            print_name = "Actividad",
            regex = ".*"
        ),
        meta = list(
            param_name = "13",
            print_name = "Meta",
            regex = ".*"
        ),
        funcion = list(
            param_name = "8",
            print_name = "Funcion",
            regex = ".*"
        ),
        division_funcional = list(
            param_name = "33",
            print_name = "Division Funcional",
            regex = ".*"
        ),
        grupo_funcional = list(
            param_name = "34",
            print_name = "Grupo Funcional",
            regex = ".*"
        ),
        trimestre_gasto = list(
            param_name = "22",
            print_name = "Trimestre",
            regex = ".*"
        ),
        trimestre_ingreso = list(
            param_name = "16",
            print_name = "Trimestre",
            regex = ".*"
        ),
        mes_gasto = list(
            param_name = "23",
            print_name = "Mes",
            regex = ".*"
        ),
        mes_ingreso = list(
            param_name = "17",
            print_name = "Mes",
            regex = ".*"
        )
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
