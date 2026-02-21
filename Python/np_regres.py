#!/usr/bin/env python3
import numpy as np

# X = np.array([1.02, 2.08, 2.89, 4.04, 5.32, 5.83, 7.26, 7.96, 9.11, 9.99])
# Y = np.array([1.15, 0.85, 1.56, 1.72, 4.32, 5.07, 5.00, 5.31, 6.17, 7.04])
X = np.array([16, 18, 23, 24, 28, 29, 26, 31, 32, 34])
Y = np.array([20, 24, 28, 22, 32, 28, 32, 36, 41, 41])
p = 1
k = 2
n = 10
mean_x = np.mean(X)
mean_y = np.mean(Y)
cov = np.cov(X,Y, bias=True)[0,1]
correlation_coefficient = np.corrcoef(X,Y)[0,1]
estimated_t = correlation_coefficient / np.sqrt((1-(correlation_coefficient)**2) / (np.size(X) - 2))
beta = np.sum((X-mean_x) * (Y-mean_y)) / np.sum((X-mean_x)**2)
alpha = mean_y - (beta*mean_x)
y_pred = alpha + (beta*X)
errors = Y - y_pred
SE = np.sum(errors)
y_pred_2 = alpha + (beta*X)
squared_errors = (Y - y_pred)**2
SSE = np.sum(squared_errors)
sum_squared_regression = ((alpha + beta*X) - mean_y)**2
SSR = np.sum(sum_squared_regression)
SST = SSE + SSR
R_squared = SSR / SST
R_squared_adjusted = 1 - (((n-1)/(n-p-1)) * (1-R_squared))
estimated_F = (R_squared / (k-1)) / ((1-R_squared) / (n-k))
print(f"X Mean > {mean_x}")
print(f"Y Mean > {mean_y}")
print(f"Cov(x,y) > {cov}")
print(f"correlation coefficient > {correlation_coefficient}")
print(f"estimated t > {estimated_t}")
print(f"Beta > {beta}")
print(f"Alpha > {alpha}")
print(f"Sum of errors > {SE} ~= 0")
print(f"Sum of squared errors > {SSE}")
print(f"Sum of squared regression > {SSR}")
print(f"Sum squared total > {SST}")
print(f"R² > {R_squared}")
print(f"R²_ > {R_squared_adjusted}")
print(f"Estimated F > {estimated_F}")
print(np.var(X))
print(np.cov(Y))