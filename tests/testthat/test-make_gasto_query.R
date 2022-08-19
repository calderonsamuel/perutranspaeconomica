test_that("make_gasto_query() works as expected", {
  expect_type(make_gasto_query(years = 2022), "list")
})
