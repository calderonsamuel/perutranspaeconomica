#' Elegir la institucion que utiliza el presupuesto
#'
#' Estas funciones permiten desglosar la busqueda haciendo uso del clasificador institucional.
#' 
#' @inheritParams consultar
#' @param nivel chr. Nivel de gobierno. Puede ser "E" (gobierno nacional),
#' "M" (gobiernos locales) o "R" (gobiernos regionales). Si es "E" o "R",
#' le corresponde `sector`. Si es "M", le corresponde `goblocal_o_manc`.
#' @param sector chr. Codigo de sector, de forma "XX" (2).
#' @param pliego chr. Código de pliego, de forma "XXX" (3).
#' @param unidad_ejecutora chr. Código de Unidad Ejecutora. No tiene forma estandar
#' @param goblocal_o_manc chr. Escoger entre "M" (gobierno local)
#' o "N" (mancomunidad). Si es "M", desbloque `departamento`, `provincia` y `municipalidad`.
#' Si es "N", le corresponde `mancomunidad`.
#' @param mancomunidad chr. Código de mancomunidad, de forma "XXXXXX" (6).
#' @param departamento chr. Código de departamento. El valor "07" corresponde a Callao.
#' @param provincia chr. Código de provincia. El valor "01" corresponde a capital de departamento.
#' @param municipalidad chr. Código de municipalidad, de forma "XXXXXX". No corresponde con ubigeo.
#'
#' @return Un data.frame con clase <transpaeco>
#' @export
elegir_institucion <- function(x, 
                               nivel = NULL,
                               sector = NULL,
                               pliego = NULL,
                               unidad_ejecutora = NULL,
                               goblocal_o_manc = NULL,
                               mancomunidad = NULL,
                               departamento = NULL,
                               provincia = NULL,
                               municipalidad = NULL) {
    
    update_list <- list(
        nivel = nivel,
        sector = sector,
        pliego = pliego,
        unidad_ejecutora = unidad_ejecutora,
        goblocal_o_manc = goblocal_o_manc,
        mancomunidad = mancomunidad,
        departamento = departamento,
        provincia = provincia,
        municipalidad = municipalidad
    )
    
    names(update_list) <- names(update_list) %>%
        paste0("_", S7::prop(x, "modulo"))
    
    update_parameter(
        x = x, 
        param = "institucion",
        update_list =  update_list
    )
}

#' @rdname elegir_institucion
#' @export
elegir_quien_gasta <- function(x,
                               nivel = NULL,
                               sector = NULL,
                               pliego = NULL,
                               unidad_ejecutora = NULL,
                               goblocal_o_manc = NULL,
                               mancomunidad = NULL,
                               departamento = NULL,
                               provincia = NULL,
                               municipalidad = NULL) {
    elegir_institucion(
        x = x,
        nivel = nivel,
        sector = sector,
        pliego = pliego,
        unidad_ejecutora = unidad_ejecutora,
        goblocal_o_manc = goblocal_o_manc,
        mancomunidad = mancomunidad,
        departamento = departamento,
        provincia = provincia,
        municipalidad = municipalidad
    )
}
