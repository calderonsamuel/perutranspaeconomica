single_request <- S7::new_class(
    name = "single_request",
    properties = list(
        params = S7::class_list,
        url = S7::class_character
    )
)

perform <- S7::new_generic("perform", "x", function(x, max_tries = NULL, max_seconds = NULL) {
    S7::S7_dispatch()
})

S7::method(perform, single_request) <- function(x, max_tries = NULL, max_seconds = NULL) {
    url <- S7::prop(x, "url")
    params <- S7::prop(x, "params")
    
    httr2::request(url) |> 
        httr2::req_user_agent("perutranspaeconomica (https://perutranspaeconomica.samuelenrique.com)") |>
        httr2::req_url_query(`_tgt` = "json", `_uhc` = "yes", cpage = 1, psize = 1000) |> 
        httr2::req_url_query(!!!params) |> 
        httr2::req_retry(max_tries = max_tries, max_seconds = max_seconds) |> 
        httr2::req_perform()
}

