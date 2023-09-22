test_that("elegir_periodo_anual() falla con malos inputs", {
    df <- iniciar_transparencia_economica()
    expect_error(df %>% elegir_periodo_anual())
    expect_error(df %>% elegir_periodo_anual(2011))
    expect_error(df %>% elegir_periodo_anual(list(2022)))
    expect_error(df %>% elegir_periodo_anual(current_year() + 1))
})

test_that("no se puede elegir otros parametros antes que periodo anual", {
    df <- iniciar_transparencia_economica()
    
    df %>% elegir_institucion() %>% expect_error(regexp = "elegir_periodo_anual")
    df %>% elegir_destino() %>% expect_error(regexp = "elegir_periodo_anual")
    df %>% elegir_estructura() %>% expect_error(regexp = "elegir_periodo_anual")
    df %>% elegir_origen() %>% expect_error(regexp = "elegir_periodo_anual")
    df %>% elegir_tiempo() %>% expect_error(regexp = "elegir_periodo_anual")
    df %>% elegir_lugar() %>% expect_error(regexp = "elegir_periodo_anual")
})

test_that("elegir_periodo_anual() returns expected objects", {
    df <- iniciar_transparencia_economica() %>% 
        elegir_periodo_anual(periodo = current_year())
    expect_s3_class(df, "data.frame")
})

test_that("periodos anuales distintos dan diferentes PIA", {
    df1 <- iniciar_transparencia_economica() %>% elegir_periodo_anual(2020) %>% consultar() %>% suppressMessages()
    df2 <- iniciar_transparencia_economica() %>% elegir_periodo_anual(2021) %>% consultar() %>% suppressMessages()

    expect_false(identical(df1$pia, df2$pia))
})

test_that("Se pueden consultar varios periodos al mismo tiempo", {
    iniciar_transparencia_economica() %>%
        elegir_periodo_anual(2019:2021) %>%
        consultar() %>%
        suppressMessages() %>%
        expect_s3_class(class = c("data.frame"))
})
