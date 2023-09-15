elegir_estructura <- function(x,
                              generica = NULL,
                              subgenerica = NULL,
                              detalle_subgenerica = NULL,
                              especifica = NULL,
                              detalle_especifica = NULL) {
    
    update_parameter(
        x = x,
        param = "estructura",
        update_list = list(
            generica = generica,
            subgenerica = subgenerica,
            detalle_subgenerica = detalle_subgenerica,
            especifica = especifica,
            detalle_especifica = detalle_especifica
        )
    )
}
