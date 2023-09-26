test_that("funciones opinionadas fallan adecuadamente", {
    df_gasto <- iniciar_transparencia_economica(modulo = "gasto") %>%
        elegir_periodo_anual(current_year())
    
    df_ingreso <- iniciar_transparencia_economica(modulo = "ingreso") %>%
        elegir_periodo_anual(current_year())
    
    df_gasto %>% elegir_quien_recauda(nivel = "todos") %>% expect_error("gasto")
    df_gasto %>% elegir_fuentes_de_recaudacion(rubro = "todos") %>% expect_error("gasto")
    df_gasto %>% elegir_cuando_se_hizo_recaudacion(trimestre = "todos") %>% expect_error("gasto")
    df_gasto %>% elegir_como_se_estructura_recaudacion(generica = "todos") %>% expect_error("gasto")
    
    df_ingreso %>% elegir_quien_gasta(nivel = "todos") %>% expect_error("ingreso")
    df_ingreso %>% elegir_en_que_se_gasta(categoria_presupuestal = "todos") %>% expect_error("ingreso")
    df_ingreso %>% elegir_como_se_estructura_gasto(generica = "todos") %>% expect_error("ingreso")
    df_ingreso %>% elegir_donde_se_gasta(departamento_meta = "todos") %>% expect_error("ingreso")
    df_ingreso %>% elegir_cuando_se_hizo_gasto(trimestre = "todos") %>% expect_error("ingreso")
    df_ingreso %>% elegir_con_que_se_financia(rubro = "todos") %>% expect_error("ingreso")
})
