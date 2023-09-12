test_that("api_gasto() funciona por defecto", {
    api_gasto() %>%
        expect_type(type = "character")
})

test_that("api_gasto() permite especificar modulo y actualizacion", {
    api_gasto(actualizacion = "diaria") %>%
        expect_type(type = "character")

    api_gasto(modulo = "ingreso") %>%
        expect_type(type = "character")
})

test_that("api_gasto() genera errores cuando debe" , {
    api_gasto(modulo = "moduloInexistente") %>%
        expect_error(regexp = "modulo")

    api_gasto(actualizacion = "actualizacionInexistente") %>%
        expect_error(regexp = "actualizacion")
})
