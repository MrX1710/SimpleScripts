#prob_values
P <- c(0.05, 0.10, 0.23, 0.11, 0.21, 0.15, 0.12, 0.03)
#stock_returns
A <- c(0.08, 0.16, -0.04, 0.12, 0.11, 0.21, -0.05, 0.13)
B <- c(0.26, 0.07, 0.21, 0.07, -0.07, 0.08, 0.13, 0.05)
C <- c(0.08, 0.25, 0.02, 0.05, 0.11, -0.01, 0.12, 0.09)

data <- data.frame(A,B,C)
results <- sapply(data, function(r) { E_Ri <- sum(P*r)
c(E_Ri = E_Ri, Volatility = sqrt(sum(P*(r - E_Ri)^2)))})
print(results)

best_asset <- "A"
if (results["E_Ri", "B"] > results["E_Ri", best_asset] &
           results["Volatility", "B"] > results["Volatility", best_asset]) {
  best_asset <- "B"
}
if (results["E_Ri", "C"] > results["E_Ri", best_asset] &
           results["Volatility", "C"] > results["Volatility", best_asset]) {
  best_asset <- "C"
}
cat("\nBest asset based on a risky-taking(risk-lover) investor is: ", best_asset)

cov_a_b <- cov(A,B)
w = rep(1/3, 3) #equal distribution

cat("\n\nCov(A,B): ", cov_a_b)
cat("\nWeights: ",w)

portfolio_return <- sum(w*results["E_Ri",])
portfolio_covariance <- cov(data)
portfolio_correlation <- cor(data)
portfolio_variance <- t(w) %*% portfolio_covariance %*% w #w^T∑w
portfolio_volatility <- sqrt(portfolio_variance)

cat("\n\nPortfolio covariance matrix:\n")
print(portfolio_covariance)
cat("\nPortfolio correlation matrix:\n")
print(portfolio_correlation)
cat("\nPortfolio's Expected Return:")
print(portfolio_return*100)
cat("\nPortfolio's volatility:")
print(portfolio_volatility*100)