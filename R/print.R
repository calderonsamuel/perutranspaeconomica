#' @export
print.sep_df <- function(x) {
    cli_titulo(x)
    cli::cli_h2("Parámetros de consulta")
    cli_query(x)
    cli::cli_h2("Data")
    if(nrow(x) == 0) cli_sin_consulta() else NextMethod()
    invisible(x)
}

cli_query <- function(x) {
    if (query_is_empty(x)) {
        cli::cli_alert_info("No se ha definido parámetros de consulta")
    } else {
        cli_years(x)
        cli_quien_gasta(x)
        cli_en_que_se_gasta(x)
        cli_con_que_se_financia(x)
        cli_como_se_estructura(x)
        cli_donde_se_gasta(x)
        cli_cuando_se_hizo_gasto(x)
    }
}

cli_sin_consulta <- function() {
    cli::cli_alert_info("No se ha ejecutado ninguna consulta")
}

cli_titulo <- function(x) {
    actualizacion <- get_actualizacion(x)
    cli::cli_h1("Seguimiento a la ejecución presupuestal ({.emph actualización {actualizacion}})")
}

cli_years <- function(x) {
    query <- get_query(x) |> purrr::flatten()
    if (!is.null(query$years)) {
        cli::cli_li("{.strong Años:}")
        cli::cli_ul()
        cli::cli_li(glue::glue_collapse(query$years, sep = ", ", last = " y "))
    }
}

cli_quien_gasta <- function(x) {
    consulta <- get_query(x)$quien_gasta
    if (!rlang::is_empty(consulta)) {
        cli::cli_li("{.strong ¿Quién gasta?:}")
        cli::cli_ul()
        cli_li_optional(consulta$nivel, "Nivel de gobierno")
        cli_li_optional(consulta$sector, "Sector")
        cli_li_optional(consulta$pliego, "Pliego")
        cli_li_optional(consulta$unidad_ejecutora, "Unidad Ejecutora")
        cli_li_optional(consulta$goblocal_o_manc, "Gobierno local o mancomunidad")
        cli_li_optional(consulta$mancomunidad, "Mancomunidad")
        cli_li_optional(consulta$departamento, "Departamento")
        cli_li_optional(consulta$provincia, "Provincia")
        cli_li_optional(consulta$municipalidad, "Municipalidad")
    }
}

cli_en_que_se_gasta <- function(x){

}

cli_con_que_se_financia <- function(x){

}

cli_como_se_estructura <- function(x){

}

cli_donde_se_gasta <- function(x){

}

cli_cuando_se_hizo_gasto <- function(x){

}

cli_li_optional <- function(x, label) {
    # print as list item if not null
    if(!is.null(x)) cli::cli_li("{label}: {x}")
}

