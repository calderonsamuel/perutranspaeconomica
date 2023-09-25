#' @importFrom rlang .data
process_tbl <- function(tbl) {
    num_columns <- c("pia", "pim", "certificacion", "compromiso_anual",
                     "atencion_de_compromiso_mensual", "devengado", "girado", "avance_percent",
                     "recaudado")
    tbl %>%
        remove_first_column() %>%
        unique() %>% # keep only unique permutations, returns data.frame
        # dplyr::filter(!is.na(readr::parse_number(.data$pim))) %>%
        dplyr::filter(dplyr::across(.cols = tidyselect::any_of(c("certificacion", "recaudado")), ~!is.na(readr::parse_number(.x)))) %>%
        separate_cod_desc() %>%
        dplyr::mutate(dplyr::across(.cols = tidyselect::any_of(num_columns), .fns = readr::parse_number)) %>%
        suppressWarnings()
}

remove_first_column <- function(x) x[ , -1, drop = FALSE]
