x <- c(0.1, 0.07, 0.13, 0.14, 0.16)
y <- c(0.16, 0.11, 0.09, 0.15, 0.08)
z <- c(0.06, 0.1, 0.13, 0.14, 0.16)

data <- data.frame(x,y,z)
expected_x <- mean(x) #Ri
expected_y <- mean(y)
expected_z <- mean(z)

volatility_x <- sd(x) #𝜎
volatility_y <- sd(y)
volatility_z <- sd(z)

#sapply is a function that applies a function to each element
#and returns the result as a vector or a matrix
print(sapply(data, function(r) c(mean = mean(r), sd = sd(r))))
cov_matrix <- cov(data)
corr_matrix <- cor(data)
cat("\nCovariance Matrix:\n") 
print(cov_matrix)
cat("\nCorrelation matrix:\n")
print(corr_matrix)

#visualizing the data
par(bg = 'black')
plot(x, type = "l", col = 'red', ylim = c(0,0.18), main = 'Historical Returns', 
     col.main = 'white', col.lab = 'white', xlab = "Time", ylab = "Return")
lines(y, col = 'purple')
lines(z, col = 'yellow')
legend("bottomright", legend = c("X","Y","Z"), col = c('red','purple', 'yellow'),
       lty = 1, bg = 'white')
axis(1, col = 'white', col.axis = 'white')
axis(2, col = 'white', col.axis = 'white')