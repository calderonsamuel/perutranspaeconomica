#' @importFrom rlang .data
process_tbl <- function(tbl) {
    num_columns <- c("pia", "pim", "certificacion", "compromiso_anual",
                     "atencion_de_compromiso_mensual", "devengado", "girado", "avance_percent",
                     "recaudado")
    
    tmp_tbl <- tbl %>%
        remove_first_column() %>%
        unique()# keep only unique permutations, returns data.frame
    
    # modulo "gasto" tiene "certification" y modulo "ingreso" tiene "recaudado"
    if ("certificacion" %in% names(tmp_tbl)) {
        tmp_tbl <- tmp_tbl %>%
            dplyr::filter(!is.na(readr::parse_number(.data$certificacion)))
    } else if ("recaudado" %in% names(tmp_tbl)) {
        tmp_tbl <- tmp_tbl %>%
            dplyr::filter(!is.na(readr::parse_number(.data$recaudado)))

    }

    tmp_tbl %>%
        separate_cod_desc() %>%
        dplyr::mutate(dplyr::across(.cols = tidyselect::any_of(num_columns), .fns = readr::parse_number)) %>%
        suppressWarnings()
}

remove_first_column <- function(x) x[ , -1, drop = FALSE]
