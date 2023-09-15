#' @import S7
pte_params <- new_class(
    name = "pte_params",
    properties = list(
        periodo_anual = new_property(
            class = class_list,
            default = list(
                periodo = NULL
            )
        ),
        institucion = new_property(
            class = class_list,
            default = list(
                nivel = NULL,
                sector = NULL,
                pliego = NULL,
                unidad_ejecutora = NULL,
                goblocal_o_manc = NULL,
                mancomunidad = NULL,
                departamento = NULL,
                provincia = NULL,
                municipalidad = NULL
            )
        ),
        destino = new_property(
            class = class_list,
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
        origen = new_property(
            class = class_list,
            default = list(
                fuente_financiamiento = NULL,
                rubro = NULL,
                tipo_de_recurso = NULL
            )
        ),
        estructura = new_property(
            class = class_list,
            default = list(
                generica = NULL,
                subgenerica = NULL,
                detalle_subgenerica = NULL,
                especifica = NULL,
                detalle_especifica = NULL
            )
        ),
        lugar = new_property(
            class = class_list,
            default = list(
                departamento_meta = NULL
            )
        ),
        tiempo = new_property(
            class = class_list,
            default = list(
                trimestre = NULL,
                mes = NULL
            )
        )
    )
)

update_single_prop <- new_generic("update_single_prop", "x")

method(update_single_prop, pte_params) <- function(x, param, prop, value) {
    param_content <- prop(x, param)
    
    if (! prop %in% names(param_content)) {
        cli::cli_abort("{.str {prop}} no es una propiedad de {.code {param}}")
    }
    
    if (sum(value == "todos") > 1) {
        cli::cli_abort("{.str todos} aparece más de una vez en {.code {prop}}")
    }
    
    param_content[[prop]] <- value
    prop(x, param) <- param_content
    
    x
}

transpaeco <- new_class(
    name = "transpaeco",
    properties = list(
        modulo = new_property(
            class = class_character, 
            default = "gasto"
        ),
        actualizacion = new_property(
            class = class_character, 
            default = "diaria"
        ),
        parametros = new_property(
            class = pte_params, 
            default = pte_params()
        ),
        traduccion = new_property(
            class = class_list,
            getter = function(self) {
                self@parametros |> 
                    props() |> 
                    purrr::flatten() |> 
                    purrr::discard(is.null)
            }
        )
    ), 
    validator = function(self) {
        propiedades_de_desagregacion <- purrr::map_lgl(self@traduccion, ~any(.x == "todos")) |> sum()
        
        if (!self@modulo %in% c("ingreso", "gasto")) {
            "@modulo debe ser ingreso o gasto"
        } else if (!self@actualizacion %in% c("diaria", "mensual")) {
            "@actualizacion debe ser diaria o mensual"
        } else if (propiedades_de_desagregacion > 1) {
            "No puede haber más de una propiedad con valor \"todos\""
        }
    }
)

update_parameter <- new_generic("set_param", "x")

method(update_parameter, transpaeco) <- function(x, param, update_list) {
    params_list <- prop(x, "parametros")
    
    update_list <- purrr::discard(update_list, is.null)
    
    if (rlang::is_empty(update_list)) {
        cli::cli_abort("Todos los argumentos de {.strong {param}} son {.code NULL}")
    }
    
    purrr::iwalk(update_list, function(value, name) {
        params_list <<- update_single_prop(params_list, param, name, value)
    })
    
    prop(x, "parametros") <- params_list
    
    x
}
