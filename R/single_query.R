single_request <- S7::new_class(
    name = "single_request",
    properties = list(
        
        modulo = S7::class_character,
        
        actualizacion = S7::class_character,
        
        query = S7::class_list,
        
        response = S7::class_list, # will hold an httr2_response
        
        url = S7::new_property(
            class = S7::class_character,
            getter = function(self) {
                api <- list(
                    gasto = list(
                        diaria = "https://apps5.mineco.gob.pe/transparencia/Navegador/Navegar_7.aspx",
                        mensual = "https://apps5.mineco.gob.pe/transparencia/mensual/Navegar_6.aspx"
                    ),
                    ingreso = list(
                        diaria = "https://apps5.mineco.gob.pe/transparenciaingresos/Navegador/Navegar_6.aspx",
                        mensual = "https://apps5.mineco.gob.pe/transparenciaingresos/mensual/Navegar_6.aspx"
                    )
                )
                
                api[[self@modulo]][[self@actualizacion]]
            }
        )
    )
)

single_perform <- S7::new_generic("single_perform", "x", function(x, max_tries = NULL, max_seconds = NULL) {
    S7::S7_dispatch()
})

S7::method(single_perform, single_request) <- function(x, max_tries = NULL, max_seconds = NULL) {
    url <- S7::prop(x, "url")
    params <- S7::prop(x, "params")
    
    response <- httr2::request(url) %>% 
        httr2::req_user_agent("perutranspaeconomica (https://perutranspaeconomica.samuelenrique.com)") %>%
        httr2::req_url_query(`_tgt` = "json", `_uhc` = "yes", cpage = 1, psize = 1000) %>% 
        httr2::req_url_query(!!!params) %>% 
        httr2::req_retry(max_tries = max_tries, max_seconds = max_seconds) %>% 
        httr2::req_perform()
    
    prop(x, "response") <- list(response)
    
    x
}

single_process_tbl <- S7::new_generic("single_process_tbl", "x") 

