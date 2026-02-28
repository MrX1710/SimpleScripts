P <- c(0.05, 0.10, 0.23, 0.11, 0.21, 0.15, 0.12, 0.03)
A <- c(0.08, 0.16, -0.04, 0.12, 0.11, 0.21, -0.05, 0.13)
B <- c(0.26, 0.07, 0.21, 0.07, -0.07, 0.08, 0.13, 0.05)
C <- c(0.08, 0.25, 0.02, 0.05, 0.11, -0.01, 0.12, 0.09)

data <- data.frame(A,B,C)
results <- sapply(data, function(r) { E_Ri <- sum(P*r)
c(E_Ri = E_Ri, Volatility = sqrt(sum(P*(r - E_Ri)^2)))})
results <- as.matrix(results)
print(results)
best_asset <- "A"

if ((results["E_Ri", "B"] > results["E_Ri", best_asset] &
           results["Volatility", "B"] > results["Volatility", best_asset])) {
  best_asset <- "B"
}
if ((results["E_Ri", "C"] > results["E_Ri", best_asset] &
           results["Volatility", "C"] > results["Volatility", best_asset])) {
  best_asset <- "C"
}
cat("\nBest asset based on a risky-taking investor behaviour is: ", best_asset)

w = rep(1/3, 3)
cat("\nWeights: ",w)
Returns <- as.matrix(data)
covariance_matrix <- matrix(0, ncol = 3, nrow = 3)
colnames(covariance_matrix) <- rownames(covariance_matrix) <- colnames(data)
sd_vector <- results['Volatility',]

for (i in 1:3) {
  for (j in 1:3) {
    covariance_matrix[i,j] <- sum( P * (Returns[,i] - results["E_Ri",i])
    * (Returns[,j] - results["E_Ri",j]))
  }
}

portfolio_return <- sum(w*results["E_Ri",])
portfolio_covariance <- covariance_matrix
portfolio_correlation <- covariance_matrix / sd_vector %o% sd_vector
portfolio_variance <- t(w) %*% portfolio_covariance %*% w #w^T∑w
portfolio_volatility <- sqrt(portfolio_variance)

cat("\n\nPortfolio covariance matrix:\n")
print(portfolio_covariance)
cat("\nPortfolio correlation matrix:\n")
print(portfolio_correlation)
cat("\nPortfolio's Expected Return(%):")
print(portfolio_return*100)
cat("\nPortfolio's volatility(%):")
print(portfolio_volatility*100)

plot(A, type = "l", col = 'red',
     main = "Probability return", ylim = range(c(A,B,C)),
     xlab = "State", ylab = "Returns")
lines(B, col = 'blue')
lines(C, col = 'purple')
abline(h = 0, lty = 2, col = "black")
legend("bottomright", legend = c("A", "B", "C"),
       col = c("red", "blue", "purple"), lty = 1)

plot(results["E_Ri", ], results["Volatility", ],
     col = c("red", "blue", "purple"),
     pch = 15, main = "Return-Volatility plot",
     xlab = "Returns", ylab = "Volatility")
text(results["E_Ri",], results["Volatility",],
     labels = colnames(results), pos = 2)