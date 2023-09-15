elegir_tiempo <- function(x,
                          trimestre = NULL,
                          mes = NULL) {
    
    update_parameter(
        x = x,
        param = "tiempo",
        update_list = list(
            trimestre = trimestre,
            mes = mes
        )
    )
}
