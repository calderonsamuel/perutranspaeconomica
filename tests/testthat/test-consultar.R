test_that("consultar() falla si no se especifica año de búsqueda", {
    df <- iniciar_transparencia_economica()
    df %>% 
        consultar() %>% 
        suppressMessages() %>% 
        expect_error()
})

test_that("consultar() devuelve un objeto <data.frame>", {
    df <- iniciar_transparencia_economica() %>% 
        elegir_periodo_anual(periodo = current_year())
    
    df %>% 
        consultar() %>% 
        suppressMessages() %>% 
        expect_s3_class("data.frame")
})

test_that("consultar() with elegir_quien_gasta() returns a data frame", {
    df <- iniciar_transparencia_economica() %>%
        elegir_periodo_anual(periodo = current_year())
    
    result <- df %>% 
        elegir_quien_gasta(nivel = "todos") %>% 
        consultar() %>% 
        suppressMessages()
    
    expect_s3_class(result, "data.frame")
})

test_that("consultar() with elegir_como_se_estructura_gasto() returns a data frame", {
    df <- iniciar_transparencia_economica() %>%
        elegir_periodo_anual(periodo = current_year())
    
    result <- df %>% 
        elegir_como_se_estructura_gasto(generica = "todos") %>% 
        consultar() %>% 
        suppressMessages()
    
    expect_s3_class(result, "data.frame")
})

test_that("consultar() with elegir_con_que_se_financia() returns a data frame", {
    df <- iniciar_transparencia_economica() %>%
        elegir_periodo_anual(periodo = current_year())
    
    result <- df %>% 
        elegir_con_que_se_financia(fuente_financiamiento = "todos") %>% 
        consultar() %>% 
        suppressMessages()
    
    expect_s3_class(result, "data.frame")
})

test_that("consultar() with elegir_cuando_se_hizo_gasto() returns a data frame", {
    df <- iniciar_transparencia_economica() %>%
        elegir_periodo_anual(periodo = current_year())
    
    result <- df %>% 
        elegir_cuando_se_hizo_gasto(trimestre = "todos") %>% 
        consultar() %>% 
        suppressMessages()
    
    expect_s3_class(result, "data.frame")
})

test_that("consultar() with elegir_en_que_se_gasta() returns a data frame", {
    df <- iniciar_transparencia_economica() %>%
        elegir_periodo_anual(periodo = current_year())
    
    result <- df %>% 
        elegir_en_que_se_gasta(categoria_presupuestal = "todos") %>% 
        consultar() %>% 
        suppressMessages()
    
    expect_s3_class(result, "data.frame")
})

test_that("consultar() with elegir_donde_se_gasta() returns a data frame", {
    df <- iniciar_transparencia_economica() %>%
        elegir_periodo_anual(periodo = current_year())
    
    result <- df %>% 
        elegir_donde_se_gasta(departamento_meta = "todos") %>% 
        consultar() %>% 
        suppressMessages()
    
    expect_s3_class(result, "data.frame")
})

