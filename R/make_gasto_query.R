#' Armar el query detallado para consulta de ejecución presupuestal
#'
#' @param years Año del cual se quiere obtener la información
#' @inheritParams set_quien_gasta
#' @inheritParams set_en_que_se_gasta
#' @inheritParams set_con_que_se_financia
#' @inheritParams set_como_se_estructura
#' @inheritParams set_donde_se_gasta
#' @inheritParams set_cuando_se_hizo_gasto
#'
#' @return Una lista cuyos elementos tienen el key-value de los parámetros de la API
#' @export
#'
make_gasto_query <- function(years = NULL,
                             nivel = NULL,
                             sector = NULL,
                             pliego = NULL,
                             unidad_ejecutora = NULL,
                             goblocal_o_manc = NULL,
                             mancomunidad = NULL,
                             departamento = NULL,
                             provincia = NULL,
                             municipalidad = NULL,
                             categoria_presupuestal = NULL,
                             producto = NULL,
                             actividad = NULL,
                             funcion = NULL,
                             division_funcional = NULL,
                             grupo_funcional = NULL,
                             meta = NULL,
                             fuente_financiamiento = NULL,
                             rubro = NULL,
                             tipo_de_recurso = NULL,
                             generica = NULL,
                             subgenerica = NULL,
                             detalle_subgenerica = NULL,
                             especifica = NULL,
                             detalle_especifica = NULL,
                             departamento_meta = NULL,
                             trimestre = NULL,
                             mes = NULL) {


    check_years(years)

    quien_gasta <- set_quien_gasta(
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

    en_que_se_gasta <- set_en_que_se_gasta(
        categoria_presupuestal = categoria_presupuestal,
        producto = producto,
        actividad = actividad,
        funcion = funcion,
        division_funcional = division_funcional,
        grupo_funcional = grupo_funcional,
        meta = meta
    )

    con_que_se_financia <- set_con_que_se_financia(
        fuente_financiamiento = fuente_financiamiento,
        rubro = rubro,
        tipo_de_recurso = tipo_de_recurso
    )

    como_se_estructura <- set_como_se_estructura(
        generica = generica,
        subgenerica = subgenerica,
        detalle_subgenerica = detalle_subgenerica,
        especifica = especifica,
        detalle_especifica = detalle_especifica
    )

    donde_se_gasta <- set_donde_se_gasta(departamento_meta = departamento_meta)

    cuando_se_hizo <- set_cuando_se_hizo_gasto(trimestre = trimestre, mes = mes)

    params <- list(
        quien_gasta,
        en_que_se_gasta,
        con_que_se_financia,
        como_se_estructura,
        donde_se_gasta,
        cuando_se_hizo
    ) |>
        purrr::flatten() |>
        purrr::list_modify(years = years) |>
        sep_params_translate() |>
        purrr::discard(is.null)

    params |>
        purrr::map(~ifelse(.x == "todos", "", .x))
}

set_gasto_query <- function(request, ...) {
    params <- make_gasto_query(...)

    params <- purrr::list_modify(.req = request, params)

    # purrr::pmap(params, httr2::req_url_query) # fails!! :(

    do.call(httr2::req_url_query, params) # works!! :O
}

