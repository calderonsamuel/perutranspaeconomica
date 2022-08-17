#' Definir la sección '¿Quién gasta?'
#'
#' El presupuesto público peruano hace uso de clasificadores presupuestales.
#' La sección '¿quién gasta?' hace uso del clasificador institucional.
#'
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
#' @return Una lista con nombres correspondientes a los endpoints de la API
#'
set_quien_gasta <- function(nivel = NULL,
                            sector = NULL,
                            pliego = NULL,
                            unidad_ejecutora = NULL,
                            goblocal_o_manc = NULL,
                            mancomunidad = NULL,
                            departamento = NULL,
                            provincia = NULL,
                            municipalidad = NULL
) {

    list(
        nivel = nivel,
        sector = sector,
        pliego = pliego,
        unidad_ejecutora = unidad_ejecutora,
        goblocal_o_manc = goblocal_o_manc,
        mancomunidad = mancomunidad,
        departamento = departamento,
        provincia = provincia,
        municipalidad = municipalidad
    ) |>
        purrr::discard(is.null)
}
