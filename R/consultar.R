#' @export
consultar <- function(x) UseMethod("consultar")

#' @export
consultar.sep_df <- function(x) {
    query <- get_query(x) |> purrr::flatten()
    check_years(query$years)
    translated <- sep_params_translate(query)
    request <- get_req_url(x)
    expanded <- do.call(tidyr::expand_grid, translated)

    expanded |>
        split_by_row() |>
        purrr::map_dfr(consulta_individual, request = request) |>
        inherit_attr(inherit_from = x)
}

consulta_individual <- function(x, request) {
    lista <- as.list(x)
    year <- lista$y
    params <- purrr::list_modify(.req = request, lista)
    do.call(httr2::req_url_query, params) |>
        retrieve_html_body() |>
        retrive_response_tbl() |>
        process_tbl(year = year)
}

split_by_row <- function(.df) {
    .df[[".id"]] <- seq_len(nrow(.df))
    .df |>
        split(~.id) |>
       lapply(\(.x){
            .x[[".id"]] <- NULL
            .x
        })
}

inherit_attr <- function(new_df, inherit_from) {
    class(new_df) <- c("sep_df", class(new_df))
    attr(new_df, "modulo") <- attr(inherit_from, "modulo")
    attr(new_df, "actualizacion") <-  attr(inherit_from, "actualizacion")
    attr(new_df, "query") <-  attr(inherit_from, "query")
    attr(new_df, "req_url") <-  attr(inherit_from, "req_url")
    new_df
}
