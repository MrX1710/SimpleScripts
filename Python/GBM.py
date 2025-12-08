#!/usr/bin/env python3
#Geometric brownian motion simulation

import numpy as np
import matplotlib.pyplot as plt

# ---------- SETTINGS ----------
S0 = 100
mu = 0.05
sigma = 0.2
T = 1.0
dt = 1/252
N = int(T/dt)
paths = 20

# ---------- SIMULATION ----------
time = np.linspace(0, T, N)
price_paths = np.zeros((paths, N))
price_paths[:, 0] = S0

for i in range(paths):
    for t in range(1, N):
        dW = np.random.normal(0, np.sqrt(dt))
        price_paths[i, t] = price_paths[i, t-1] * (1 + mu*dt + sigma*dW)

# ---------- PLOT ----------
plt.figure(figsize=(12,6))
for i in range(paths):
    plt.plot(time, price_paths[i], label=f'Path {i+1}')

plt.title("Simulated Stock Price Paths (Geometric Brownian Motion)")
plt.xlabel("Time (years)")
plt.ylabel("Stock Price")
plt.grid(True)

# Place legend outside the plot
plt.legend(loc='center left', bbox_to_anchor=(1, 0.5))  # right side, vertically centered

plt.tight_layout()  # adjust plot to make space for legend
plt.show()