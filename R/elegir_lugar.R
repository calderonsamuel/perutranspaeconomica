elegir_lugar <- function(x, departamento_meta = NULL) {
    
    update_parameter(
        x = x,
        param = "lugar",
        update_list = list(
            departamento_meta = departamento_meta
        )
    )
}
