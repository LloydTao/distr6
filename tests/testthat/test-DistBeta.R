library(testthat)

context("Beta distribution")

test_that("parameterisation",{
  expect_silent(Beta$new())
  expect_silent(Beta$new(shape1 = 1, shape2 = 1))
  expect_equal(Beta$new(shape2 = 2)$getParameterValue("shape2"), 2)
  expect_equal(Beta$new()$getParameterValue("shape1"), 1)
})

test_that("properties & traits",{
  expect_equal(Beta$new()$valueSupport(), "continuous")
  expect_equal(Beta$new()$variateForm(), "univariate")
  expect_equal(Beta$new()$symmetry(), "symmetric")
  expect_equal(Beta$new(shape2=2)$symmetry(), "asymmetric")
  expect_equal(Beta$new()$sup(), 1)
  expect_equal(Beta$new()$inf(), 0)
  expect_equal(Beta$new()$dmax(), 1)
  expect_equal(Beta$new()$dmin(), 0)
})


B = Beta$new()
test_that("statistics",{
  expect_equal(B$mean(), 0.5)
  expect_equal(B$var(), 1/12)
  expect_equal(B$skewness(), 0)
  expect_equal(B$kurtosis(T), -1.2)
  expect_equal(B$kurtosis(F), 1.8)
  expect_equal(B$entropy(), 0)
  expect_error(B$mgf(0))
  expect_error(B$cf(1))
  expect_equal(Beta$new(shape1 = 2, shape2 = 0.34)$mode(), 1)
  expect_equal(Beta$new(shape2 = 2, shape1 = 0.34)$mode(), 0)
  expect_equal(Beta$new(shape1 = 0.1, shape2 = 0.1)$mode(), c(0,1))
  expect_equal(Beta$new(shape1 = 0.1, shape2 = 0.1)$mode(1), 0)
  expect_equal(Beta$new(shape1 = 2, shape2 = 2)$mode(), 1/2)
  expect_equal(B$pdf(1), dbeta(1,shape1=1,shape2=1))
  expect_equal(B$cdf(1), pbeta(1,shape1=1,shape2=1))
  expect_equal(B$quantile(0.324), qbeta(0.324,shape=1,shape2=1))
  expect_equal(B$cdf(B$quantile(0.324)), 0.324)
  expect_silent(B$rand(10))
})