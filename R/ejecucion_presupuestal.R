ejecucion_presupuestal <- function(actualizacion = "diaria") {
    SeguimientoEjecucion$new(actualizacion = actualizacion)
}

ejecucion_presupuestal(actualizacion = "mensual")
