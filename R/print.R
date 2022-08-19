#' @export
print.sep_df <- function(x, ...) {
    cli_titulo(x)
    cli::cli_h2("Parametros de consulta")
    cli_query(x)
    cli::cli_h2("Data")
    if(nrow(x) == 0) cli_sin_consulta() else NextMethod()
    invisible(x)
}

cli_query <- function(x) {
    query <- get_query(x)
    query_flattened <- purrr::flatten(query)
    if (rlang::is_empty(query_flattened)) {
        cli::cli_alert_info("No se ha definido parametros de consulta")
    } else {
        cli_years(query)
        cli_quien_gasta(query)
        cli_en_que_se_gasta(query)
        cli_con_que_se_financia(query)
        cli_como_se_estructura(query)
        cli_donde_se_gasta(query)
        cli_cuando_se_hizo_gasto(query)
    }
}

cli_sin_consulta <- function() {
    cli::cli_alert_info("No se ha ejecutado ninguna consulta")
}

cli_titulo <- function(x) {
    actualizacion <- get_actualizacion(x)
    cli::cli_h1("Seguimiento a la ejecucion presupuestal ({.emph actualizacion {actualizacion}})")
}

cli_years <- function(query) {
    query <- query |> purrr::flatten()
    if (!is.null(query$years)) {
        cli::cli_li("{.strong Periodo anual:}")
        cli::cli_ul()
        cli::cli_li(glue::glue_collapse(query$years, sep = ", ", last = " y "))
    }
}

cli_quien_gasta <- function(query) {
    consulta <- query$quien_gasta
    if (!rlang::is_empty(consulta)) {
        cli::cli_li("{.strong ¿Quien gasta?:}")
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

cli_en_que_se_gasta <- function(query){
    consulta <- query$en_que_se_gasta
    if (!rlang::is_empty(consulta)) {
        cli::cli_li("{.strong ¿En que se gasta?:}")
        cli::cli_ul()
        cli_li_optional(consulta$categoria_presupuestal, "Categoria presupuestal")
        cli_li_optional(consulta$producto, "Producto")
        cli_li_optional(consulta$actividad, "Actividad")
        cli_li_optional(consulta$meta, "Meta")
        cli_li_optional(consulta$funcion, "Funcion")
        cli_li_optional(consulta$division_funcional, "Division funcional")
        cli_li_optional(consulta$grupo_funcional, "Grupo funcional")
    }
}

cli_con_que_se_financia <- function(query){
    consulta <- query$con_que_se_financia
    if (!rlang::is_empty(consulta)) {
        cli::cli_li("{.strong ¿Con que se financia?:}")
        cli::cli_ul()
        cli_li_optional(consulta$fuente_financiamiento, "Fuente de financiamiento")
        cli_li_optional(consulta$rubro, "Rubro")
        cli_li_optional(consulta$tipo_de_recurso, "Tipo de recurso")
    }
}

cli_como_se_estructura <- function(query){
    consulta <- query$como_se_estructura
    if (!rlang::is_empty(consulta)) {
        cli::cli_li("{.strong ¿Como se estructura gasto?:}")
        cli::cli_ul()
        cli_li_optional(consulta$generica, "Generica")
        cli_li_optional(consulta$subgenerica, "Sub-generica")
        cli_li_optional(consulta$detalle_subgenerica, "Detalle de sub-generica")
        cli_li_optional(consulta$especifica, "Especifica")
        cli_li_optional(consulta$detalle_especifica, "Detalle de especifica")
    }
}

cli_donde_se_gasta <- function(query){
    consulta <- query$donde_se_gasta
    if (!rlang::is_empty(consulta)) {
        cli::cli_li("{.strong ¿Donde se gasta?:}")
        cli::cli_ul()
        cli_li_optional(consulta$departamento_meta, "Departamento (meta)")
    }
}

cli_cuando_se_hizo_gasto <- function(query){
    consulta <- query$cuando_se_hizo_gasto
    if (!rlang::is_empty(consulta)) {
        cli::cli_li("{.strong ¿Cuando se hizo gasto?:}")
        cli::cli_ul()
        cli_li_optional(consulta$trimestre, "Trimestre")
        cli_li_optional(consulta$mes, "Mes")
    }
}

cli_li_optional <- function(x, label) {
    # print as list item if not null
    if(!is.null(x)) cli::cli_li("{label}: {x}")
}

