test_that("getters return the expected object", {
  df <- sep()
  expect_type(get_actualizacion(df), "character")
  expect_type(get_modulo(df), "character")
  expect_type(get_query(df), "list")
  expect_s3_class(get_req_url(df), "httr2_request")
})
