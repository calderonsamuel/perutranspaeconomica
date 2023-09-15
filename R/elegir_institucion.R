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
    
    update_parameter(
        x = x, 
        param = "institucion",
        update_list =  list(
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
    )
}
