#' @title Cosine Kernel
#'
#' @description Mathematical and statistical functions for the Cosine kernel defined by the pdf,
#' \deqn{f(x) = (\pi/4)cos(x\pi/2)}
#' over the support \eqn{x \in (-1,1)}{x \epsilon (-1,1)}.
#'
#' @name Cosine
#' @template class_distribution
#' @template class_kernel
#' @template method_pdfsquared2Norm
#'
#' @export
Cosine <- R6Class("Cosine",
  inherit = Kernel, lock_objects = F,
  public = list(
    name = "Cosine",
    short_name = "Cos",
    description = "Cosine Kernel",

    #' @description
    #' The squared 2-norm of the pdf is defined by
    #' \deqn{\int_a^b (f_X(u))^2 du}
    #' where X is the Distribution, \eqn{f_X} is its pdf and \eqn{a, b}
    #' are the distribution support limits.
    pdfSquared2Norm = function(x = 0) {

      cond1 <- -pi / 32 * (sin((pi * x - 2 * pi) / 2) - sin(pi * x / 2) + (pi * x - 2 * pi) *
        cos(pi * x / 2))
      cond2 <- pi / 32 * (sin((pi * x + 2 * pi) / 2) - sin(pi * x / 2) + (pi * x + 2 * pi) *
        cos(pi * x / 2))

      kern2Norm <- ifelse(abs(x) > 2, 0, ifelse(x >= 0, cond1, cond2))

      return(kern2Norm)
    },

    #' @description
    #' The variance of a distribution is defined by the formula
    #' \deqn{var_X = E[X^2] - E[X]^2}
    #' where \eqn{E_X} is the expectation of distribution X. If the distribution is multivariate the
    #' covariance matrix is returned.
    variance = function() {
      return(1 - 8 / (pi^2))
    }
  ),

  private = list(
    .pdf = function(x, log = FALSE) {
      C_CosineKernelPdf(x, log)
    },
    .cdf = function(x, lower.tail = TRUE, log.p = FALSE) {
      C_CosineKernelCdf(x, lower.tail, log.p)
    },
    .quantile = function(p, lower.tail = TRUE, log.p = FALSE) {
      C_CosineKernelQuantile(p, lower.tail, log.p)
    }
  )
)

.distr6$kernels <- rbind(
  .distr6$kernels,
  data.table::data.table(
    ShortName = "Cos", ClassName = "Cosine",
    Support = "[-1,1]", Packages = "-"
  )
)
