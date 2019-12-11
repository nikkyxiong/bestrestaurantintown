library(bestresturantintown)

test_that("output type",
          {expect_is(cacounty(),
                     "data.frame")})
