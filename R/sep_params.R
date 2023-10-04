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
            regex = "^[0-9]{2}$",
            options = NULL
        ),
        sector_ingreso = list(
            param_name = "2",
            print_name = "Sector",
            regex = "^[0-9]{2}$",
            options = NULL
        ),
        pliego_gasto = list(
            param_name = "3",
            print_name = "Pliego",
            regex = "^[0-9]{3}$",
            options = NULL
        ),
        pliego_ingreso = list(
            param_name = "3",
            print_name = "Pliego",
            regex = "^[0-9]{3}$",
            options = NULL
        ),
        unidad_ejecutora_gasto = list(
            param_name = "4",
            print_name = "Unidad Ejecutora",
            regex = "^[0-9]{1,6}$",
            options = NULL
        ),
        unidad_ejecutora_ingreso = list(
            param_name = "4",
            print_name = "Unidad Ejecutora",
            regex = "^[0-9]{1,6}$",
            options = NULL
        ),
        departamento_gasto = list(
            param_name = "5",
            print_name = "Departamento",
            regex = "^[0-9]{2}$",
            options = NULL
        ),
        departamento_ingreso = list(
            param_name = "5",
            print_name = "Departamento",
            regex = "^[0-9]{2}$",
            options = NULL
        ),
        provincia_gasto = list(
            param_name = "6",
            print_name = "Provincia",
            regex = "^[0-9]{2}$",
            options = NULL
        ),
        provincia_ingreso = list(
            param_name = "6",
            print_name = "Provincia",
            regex = "^[0-9]{2}$",
            options = NULL
        ),
        municipalidad_gasto = list(
            param_name = "7",
            print_name = "Municipalidad",
            regex = "^[0-9]{6}$",
            options = NULL
        ),
        municipalidad_ingreso = list(
            param_name = "7",
            print_name = "Municipalidad",
            regex = "^[0-9]{6}$",
            options = NULL
        ),
        goblocal_o_manc_gasto = list(
            param_name = "37",
            print_name = "Gobierno local o mancomunidad",
            regex = NULL,
            options = c("M", "N")
        ),
        goblocal_o_manc_ingreso = list(
            param_name = "23",
            print_name = "Gobierno local o mancomunidad",
            regex = NULL,
            options = c("M", "N")
        ),
        mancomunidad_gasto = list(
            param_name = "36",
            print_name = "Mancomunidad",
            regex = "^[0-9]{6}$",
            options = NULL
        ),
        mancomunidad_ingreso = list(
            param_name = "24",
            print_name = "Mancomunidad",
            regex = "^[0-9]{6}$",
            options = NULL
        ),
        generica_gasto = list(
            param_name = "24",
            print_name = "Generica",
            regex = "^[5-7]-2-[0-9]$",
            options = NULL
        ),
        generica_ingreso = list(
            param_name = "18",
            print_name = "Generica",
            regex = "^1-[0-9]$",
            options = NULL
        ),
        subgenerica_gasto = list(
            param_name = "25",
            print_name = "Sub-generica",
            regex = "^2-[0-9]-[0-9]$",
            options = NULL
        ),
        subgenerica_ingreso = list(
            param_name = "19",
            print_name = "Sub-generica",
            regex = "^1-[0-9]-[0-9]$",
            options = NULL
        ),
        detalle_subgenerica_gasto = list(
            param_name = "26",
            print_name = "Detalle de sub-generica",
            regex = "^2-[0-9]-[0-9]-[0-9]$",
            options = NULL
        ),
        detalle_subgenerica_ingreso = list(
            param_name = "20",
            print_name = "Detalle de sub-generica",
            regex = "^1-[0-9]-[0-9]-[0-9]$",
            options = NULL
        ),
        especifica_gasto = list(
            param_name = "27",
            print_name = "Especifica",
            regex = "^2-[0-9]-[0-9]-[0-9]-[0-9]$",
            options = NULL
        ),
        especifica_ingreso = list(
            param_name = "21",
            print_name = "Especifica",
            regex = "^1-[0-9]-[0-9]-[0-9]-[0-9]$",
            options = NULL
        ),
        detalle_especifica_gasto = list(
            param_name = "28",
            print_name = "Detalle de especifica",
            regex = "^2-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]$",
            options = NULL
        ),
        detalle_especifica_ingreso = list(
            param_name = "22",
            print_name = "Detalle de especifica",
            regex = "1-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]",
            options = NULL
        ),
        fuente_financiamiento_gasto = list(
            param_name = "14",
            print_name = "Fuente de financiamiento",
            regex = NULL,
            options = 1:5
        ),
        fuente_financiamiento_ingreso = list(
            param_name = "8",
            print_name = "Fuente de financiamiento",
            regex = NULL,
            options = 1:5
        ),
        rubro_gasto = list(
            param_name = "15",
            print_name = "Rubro",
            regex = "^[0-9][0-9]$",
            options = NULL
        ),
        rubro_ingreso = list(
            param_name = "9",
            print_name = "Rubro",
            regex = "^[0-9][0-9]$",
            options = NULL
        ),
        tipo_de_recurso_gasto = list(
            param_name = "17",
            print_name = "Tipo de recurso",
            regex = "^([A-Z])|([0-9]{1,2})$",
            options = NULL
        ),
        tipo_de_recurso_ingreso = list(
            param_name = "11",
            print_name = "Tipo de recurso",
            regex = "^([A-Z])|([0-9]{1,2})$",
            options = NULL
        ),
        departamento_meta = list(
            param_name = "21",
            print_name = "Departamento (meta)",
            regex = "^[0-9]{2}",
            options = NULL
        ),
        categoria_presupuestal = list(
            param_name = "30",
            print_name = "Categoria Presupuestal",
            regex = "^[0-9]{4}",
            options = NULL
        ),
        producto = list(
            param_name = "31",
            print_name = "Producto",
            regex = "^[0-9]{7}",
            options = NULL
        ),
        actividad = list(
            param_name = "32",
            print_name = "Actividad",
            regex = "^[0-9]{7}",
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
            regex = "^[0-9]{2}",
            options = NULL
        ),
        division_funcional = list(
            param_name = "33",
            print_name = "Division Funcional",
            regex = "^[0-9]{3}",
            options = NULL
        ),
        grupo_funcional = list(
            param_name = "34",
            print_name = "Grupo Funcional",
            regex = "^[0-9]{4}",
            options = NULL
        ),
        trimestre_gasto = list(
            param_name = "22",
            print_name = "Trimestre",
            regex = NULL,
            options = 1:4
        ),
        trimestre_ingreso = list(
            param_name = "16",
            print_name = "Trimestre",
            regex = NULL,
            options = 1:4
        ),
        mes_gasto = list(
            param_name = "23",
            print_name = "Mes",
            regex = NULL,
            options = 1:12
        ),
        mes_ingreso = list(
            param_name = "17",
            print_name = "Mes",
            regex = NULL,
            options = 1:12
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
        purrr::map(~ifelse(.x == "todos", "", .x)) %>%
        stats::setNames(params_names)
}
