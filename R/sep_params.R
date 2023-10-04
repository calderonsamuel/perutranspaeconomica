params_for_query <- function() {
    list(
        periodo = list(
            param_name = "y",
            print_name = "Periodo anual",
            regex = NULL,
            options = NULL
        ),
        nivel_gasto = list(
            param_name = "1",
            print_name = "Nivel de gobierno",
            regex = NULL,
            options = c("E", "R", "M")
        ),
        nivel_ingreso = list(
            param_name = "1",
            print_name = "Nivel de gobierno",
            regex = NULL,
            options = c("E", "R", "M")
        ),
        sector_gasto = list(
            param_name = "2",
            print_name = "Sector",
            regex = "^[0-9][0-9]$",
            options = NULL
        ),
        sector_ingreso = list(
            param_name = "2",
            print_name = "Sector",
            regex = "^[0-9][0-9]$",
            options = NULL
        ),
        pliego_gasto = list(
            param_name = "3",
            print_name = "Pliego",
            regex = NULL,
            options = NULL
        ),
        pliego_ingreso = list(
            param_name = "3",
            print_name = "Pliego",
            regex = NULL,
            options = NULL
        ),
        unidad_ejecutora_gasto = list(
            param_name = "4",
            print_name = "Unidad Ejecutora",
            regex = NULL,
            options = NULL
        ),
        unidad_ejecutora_ingreso = list(
            param_name = "4",
            print_name = "Unidad Ejecutora",
            regex = NULL,
            options = NULL
        ),
        departamento_gasto = list(
            param_name = "5",
            print_name = "Departamento",
            regex = NULL,
            options = NULL
        ),
        departamento_ingreso = list(
            param_name = "5",
            print_name = "Departamento",
            regex = NULL,
            options = NULL
        ),
        provincia_gasto = list(
            param_name = "6",
            print_name = "Provincia",
            regex = NULL,
            options = NULL
        ),
        provincia_ingreso = list(
            param_name = "6",
            print_name = "Provincia",
            regex = NULL,
            options = NULL
        ),
        municipalidad_gasto = list(
            param_name = "7",
            print_name = "Municipalidad",
            regex = NULL,
            options = NULL
        ),
        municipalidad_ingreso = list(
            param_name = "7",
            print_name = "Municipalidad",
            regex = NULL,
            options = NULL
        ),
        goblocal_o_manc_gasto = list(
            param_name = "37",
            print_name = "Gobierno local o mancomunidad",
            regex = NULL,
            options = NULL
        ),
        goblocal_o_manc_ingreso = list(
            param_name = "23",
            print_name = "Gobierno local o mancomunidad",
            regex = NULL,
            options = NULL
        ),
        mancomunidad_gasto = list(
            param_name = "36",
            print_name = "Mancomunidad",
            regex = NULL,
            options = NULL
        ),
        mancomunidad_ingreso = list(
            param_name = "24",
            print_name = "Mancomunidad",
            regex = NULL,
            options = NULL
        ),
        generica_gasto = list(
            param_name = "24",
            print_name = "Generica",
            regex = NULL,
            options = NULL
        ),
        generica_ingreso = list(
            param_name = "18",
            print_name = "Generica",
            regex = NULL,
            options = NULL
        ),
        subgenerica_gasto = list(
            param_name = "25",
            print_name = "Sub-generica",
            regex = NULL,
            options = NULL
        ),
        subgenerica_ingreso = list(
            param_name = "19",
            print_name = "Sub-generica",
            regex = NULL,
            options = NULL
        ),
        detalle_subgenerica_gasto = list(
            param_name = "26",
            print_name = "Detalle de sub-generica",
            regex = NULL,
            options = NULL
        ),
        detalle_subgenerica_ingreso = list(
            param_name = "20",
            print_name = "Detalle de sub-generica",
            regex = NULL,
            options = NULL
        ),
        especifica_gasto = list(
            param_name = "27",
            print_name = "Especifica",
            regex = NULL,
            options = NULL
        ),
        especifica_ingreso = list(
            param_name = "21",
            print_name = "Especifica",
            regex = NULL,
            options = NULL
        ),
        detalle_especifica_gasto = list(
            param_name = "28",
            print_name = "Detalle de especifica",
            regex = NULL,
            options = NULL
        ),
        detalle_especifica_ingreso = list(
            param_name = "22",
            print_name = "Detalle de especifica",
            regex = NULL,
            options = NULL
        ),
        fuente_financiamiento_gasto = list(
            param_name = "14",
            print_name = "Fuente de financiamiento",
            regex = NULL,
            options = NULL
        ),
        fuente_financiamiento_ingreso = list(
            param_name = "8",
            print_name = "Fuente de financiamiento",
            regex = NULL,
            options = NULL
        ),
        rubro_gasto = list(
            param_name = "15",
            print_name = "Rubro",
            regex = NULL,
            options = NULL
        ),
        rubro_ingreso = list(
            param_name = "9",
            print_name = "Rubro",
            regex = NULL,
            options = NULL
        ),
        tipo_de_recurso_gasto = list(
            param_name = "17",
            print_name = "Tipo de recurso",
            regex = NULL,
            options = NULL
        ),
        tipo_de_recurso_ingreso = list(
            param_name = "11",
            print_name = "Tipo de recurso",
            regex = NULL,
            options = NULL
        ),
        departamento_meta = list(
            param_name = "21",
            print_name = "Departamento (meta)",
            regex = NULL,
            options = NULL
        ),
        categoria_presupuestal = list(
            param_name = "30",
            print_name = "Categoria Presupuestal",
            regex = NULL,
            options = NULL
        ),
        producto = list(
            param_name = "31",
            print_name = "Producto",
            regex = NULL,
            options = NULL
        ),
        actividad = list(
            param_name = "32",
            print_name = "Actividad",
            regex = NULL,
            options = NULL
        ),
        meta = list(
            param_name = "13",
            print_name = "Meta",
            regex = NULL,
            options = NULL
        ),
        funcion = list(
            param_name = "8",
            print_name = "Funcion",
            regex = NULL,
            options = NULL
        ),
        division_funcional = list(
            param_name = "33",
            print_name = "Division Funcional",
            regex = NULL,
            options = NULL
        ),
        grupo_funcional = list(
            param_name = "34",
            print_name = "Grupo Funcional",
            regex = NULL,
            options = NULL
        ),
        trimestre_gasto = list(
            param_name = "22",
            print_name = "Trimestre",
            regex = NULL,
            options = NULL
        ),
        trimestre_ingreso = list(
            param_name = "16",
            print_name = "Trimestre",
            regex = NULL,
            options = NULL
        ),
        mes_gasto = list(
            param_name = "23",
            print_name = "Mes",
            regex = NULL,
            options = NULL
        ),
        mes_ingreso = list(
            param_name = "17",
            print_name = "Mes",
            regex = NULL,
            options = NULL
        )
    )
}


# Example structure of params_list_from_query:
# list(param_name = value, param_name = value, ...)

# Example usage:
# params_list_from_query <- list(periodo = 2023, nivel_gasto = "E", mes_gasto = "todos")

# Explanation:
# - "periodo": Specifies the year as 2023.
# - "nivel_gasto": Specifies the level of government as "E".
# - "mes_gasto": Specifies the month, allowing "todos" to indicate all months.

translate_params_list <- function(params_list_from_query) {
    all_params <- params_for_query()
    params_names <- names(params_list_from_query) %>% 
        purrr::map_chr(~all_params[[.x]][["param_name"]])
    
    params_list_from_query %>% 
        # purrr::iwalk(~{
        #     item_regex <- all_params[[.y]][["regex"]]
        #     matches_regex <- stringr::str_detect(.x, item_regex)
        #     if (!matches_regex) {
        #         cli::cli_abort("{.y} debe hacer match con {item_regex}")
        #     }
        # }) %>%
        purrr::map(~ifelse(.x == "todos", "", .x)) %>%
        stats::setNames(params_names)
}
