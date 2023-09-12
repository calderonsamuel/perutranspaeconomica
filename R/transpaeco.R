#' @import S7
pte_params <- new_class(
    name = "pte_params",
    properties = list(
        periodo_anual = class_numeric,
        institucion = class_list,
        origen = class_list,
        estructura = class_list,
        lugar = class_list,
        tiempo = class_list
    )
)

method(print, pte_params) <- function(x) {
    cat("hi")
}

transpaeco <- new_class(
    name = "transpaeco",
    properties = list(
        modulo = new_property(class = class_character, default = "gasto"),
        actualizacion = new_property(class = class_character, default = "diaria"),
        parametros = new_property(class = pte_params, default = pte_params())
    ), 
    validator = function(self) {
        if (!self@modulo %in% c("ingreso", "gasto")) {
            "@modulo debe ser ingreso o gasto"
        } else if (!self@actualizacion %in% c("diaria", "mensual")) {
            "@actualizacion debe ser diaria o mensual"
        }
    }
)
