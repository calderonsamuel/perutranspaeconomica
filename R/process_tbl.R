#' @importFrom rlang .data
process_tbl <- function(tbl) {
    num_columns <- c("pia", "pim", "certificacion", "compromiso_anual",
                     "atencion_de_compromiso_mensual", "devengado", "girado", "avance_percent")
    tbl |>
        # janitor::remove_empty("cols") |>
        dplyr::select(-1L) |>
        dplyr::distinct(dplyr::across()) |>
        dplyr::filter(!is.na(readr::parse_number(.data$certificacion))) |>
        separate_cod_desc() |>
        dplyr::mutate(dplyr::across(tidyselect::all_of(num_columns), readr::parse_number)) |>
        suppressWarnings()
}
