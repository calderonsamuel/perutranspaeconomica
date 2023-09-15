elegir_origen <- function(x,
                          fuente_financiamiento = NULL,
                          rubro = NULL,
                          tipo_de_recurso = NULL) {
    
    update_parameter(
        x = x,
        param = "origen",
        update_list = list(
            fuente_financiamiento = fuente_financiamiento,
            rubro = rubro,
            tipo_de_recurso = tipo_de_recurso
        )
    )
}
