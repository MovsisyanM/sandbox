ci_generalized <- function(x, a, sigma = NULL) {
    mle <- mean(x)
    if (is.null(sigma)) {
        me <- qnorm(1 - a / 2, 0, 1) * sqrt(mle * (1 - mle) / length(x))
    } else {
        me <- qnorm(1 - a / 2, 0, 1) * sigma / sqrt(length(x))
    }
    ci <- c(mle - me, mle + me)
    return(ci)
}

x <- c(0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0)

ci_generalized(x, 0.05)

x <- rnorm(24, mean = 0.5, sd = 0.1)

ci_generalized(x, 0.05, sigma = 2)