test_that("consultar() falla si no se especifica año de búsqueda", {
    df <- iniciar_transparencia_economica()
    expect_error(df %>% consultar() %>% suppressMessages())

})

test_that("consultar() devuelve un objeto <data.frame>", {
    df <- iniciar_transparencia_economica() %>% 
        elegir_periodo_anual(periodo = current_year())
    
    expect_s3_class(df %>% consultar() %>% suppressMessages(), "data.frame")
})

test_that("consultar() sirve para todos los elementos de query()", {
    df <- iniciar_transparencia_economica() %>% 
        elegir_periodo_anual(periodo = current_year())
    
    expect_s3_class(df %>% elegir_quien_gasta(nivel = "todos") %>% consultar() %>% suppressMessages(), "data.frame")
    expect_s3_class(df %>% elegir_como_se_estructura_gasto(generica = "todos") %>% consultar() %>% suppressMessages(), "data.frame")
    expect_s3_class(df %>% elegir_con_que_se_financia(fuente_financiamiento = "todos") %>% consultar() %>% suppressMessages(), "data.frame")
    expect_s3_class(df %>% elegir_cuando_se_hizo_gasto(trimestre = "todos") %>% consultar() %>% suppressMessages(), "data.frame")
    expect_s3_class(df %>% elegir_en_que_se_gasta(categoria_presupuestal = "todos") %>% consultar() %>% suppressMessages(), "data.frame")
    expect_s3_class(df %>% elegir_donde_se_gasta(departamento_meta = "todos") %>% consultar() %>% suppressMessages(), "data.frame")
})
