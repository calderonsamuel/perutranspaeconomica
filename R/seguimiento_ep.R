#' Iniciar una consulta de seguimiento de ejecución presupuestal
#'
#' @inheritParams set_req_url_query
#'
#' @return Objeto con clase 'sep_df' en el que se pueden agregar parámetros de consulta
#' @export
seguimiento_ep <- function(actualizacion = "diaria") {
    query <- list(
        years = NULL,
        quien_gasta = set_quien_gasta(),
        en_que_se_gasta = set_en_que_se_gasta(),
        con_que_se_financia = set_con_que_se_financia(),
        donde_se_gasta = set_donde_se_gasta(),
        como_se_estructura = set_como_se_estructura(),
        cuando_se_hizo_gasto = set_cuando_se_hizo_gasto()
    )
    # 'R/sep_df.R' defines the S3 class
    sep_df(query = query, actualizacion = actualizacion)
}
