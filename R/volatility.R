weight_a <- 0.333
weight_b <- 0.667
sd_a <- 0.2
sd_b <- 0.1
correlation <- 0.85

w <- c(weight_a, weight_b) #weight vector
sd <- c(sd_a, sd_b) #standard derivation vector

cov_matrix <- matrix(0, nrow = 2, ncol = 2) #covariance matrix
cov_matrix[1,1] <- sd_a^2
cov_matrix[2,2] <- sd_b^2
cov_matrix[1,2] <- correlation * sd_a * sd_b
cov_matrix[2,1] <- correlation * sd_a * sd_b

portfolio_variance <- t(w) %*% cov_matrix %*% w #w^T∑w
portfolio_volatility <- sqrt(portfolio_variance)

cat("Portfolio Variance:", round(portfolio_variance, 6), "\n")
cat("Portfolio Volatility:", round(portfolio_volatility * 100, 5), "%\n")