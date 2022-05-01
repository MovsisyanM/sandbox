# --- Problem 1 ---
# a.1
set.seed(1234567);

# a.2
mu <- -2;
a <- 0.05;
n <- 74;
x <- rnorm(n, mu, 3.72);

# a.3
devar <- sum((x - mu) ** 2);

c(devar / qchisq(1 - a / 2, n - 1), devar / qchisq(a / 2, n - 1));

3.72 ** 2


# a.4
devar <- sum((x - mean(x)) ** 2);

c(devar / qchisq(1 - a / 2, n - 1), devar / qchisq(a / 2, n - 1)) ;


# a.5
sqrt(c(devar / qchisq(1 - a / 2, n - 1), devar / qchisq(a / 2, n - 1)));


# a.6
library(EnvStats, verbose = 0);
varTest(x)$conf.int;


# b
x <- c(135.21, 136.39, 123.55, 132.78, 141.10,
    136.78, 130.78, 140.84, 136.82, 135.80,
    134.46, 142.94, 141.38, 137.17, 135.41,
    137.03, 131.59, 133.65, 137.95, 134.79)

a <- 0.1;
n <- length(x);
x_bar <- mean(x);
ssum <- sum((x - x_bar) ** 2);
ld <- qchisq(1 - a / 2, n - 1);
ud <- qchisq(a / 2, n - 1);

lb <- sqrt(ssum / ld);
ub <- sqrt(ssum / ud);

c(lb, ub);


# --- Problem 2 ---
# a.1
data <- read.csv("res/all_seasons.csv");
hist(data$player_height);

# a.2

x_bar <- mean(data$player_height);
x_bar



# a.3

n <- length(data$player_height);
standard_dev <- sd(data$player_height);
a <- 0.05;
me <- qt(1 - a / 2, n - 1) * standard_dev / sqrt(n);

c(x_bar - me, x_bar + me);


# --- Problem 4 ---

a <- 0.01
x <- c(66, 79, 80, 74, 81, 79, 65, 78, 77, 69);
print(c("t at 1 - a", qt(1 - a, 9)));
print(c(
    "t-value",
    toString(t.test(x, mu = 70, alternative = "greater")$statistic)
));


t.test(x, mu = 70, alternative = "greater")$p.value



z_test <- function(x, sigma, mu, conf_level = 0.95, alternative = "two.sided") {
    a <- 1 - conf_level

    if (alternative == "two.sided") {
        z <- qnorm(1 - a / 2);
    } else if (alternative == "less") {
        z <- qnorm(1 - a);
    } else if (alternative == "greater") {
        z <- qnorm(a);
    } else {
        stop("Invalid alternative");
    }

    n <- length(x);

    z_value <- (mean(x) - mu) / (sigma / sqrt(n));

    result <- list(
        statistic = z_value,
        p.value = pnorm(z_value),
        conf.int = c(
            mean(x) - z * sigma / sqrt(n),
            mean(x) + z * sigma / sqrt(n)
        ),
        estimate = mean(x),
        null.value = mu,
        alternative = alternative
    );

    return(result);
}

z_test(c(66.8, 60.9, 62.2, 59.0,
    55.1, 63.8, 59.1, 60.0, 68.3,
    56.7, 57.6, 56.1, 59.0, 61.5),
    sigma = 5, mu = 60, alternative = "less")