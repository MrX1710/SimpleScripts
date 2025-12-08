#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

# Generate a long series of white noise samples
np.random.seed(42)  # For reproducibility
num_samples = 10000  # Number of samples

# White noise values drawn from a standard normal distribution (mean=0, variance=1)
white_noise = np.random.normal(0, 1, num_samples)

# Calculate the running average of the white noise samples
cumulative_mean = np.cumsum(white_noise) / np.arange(1, num_samples + 1)

# Plot the first 100 samples and the running average
plt.figure(figsize=(10, 6))

# Subplot 1: White noise samples
plt.subplot(2, 1, 1)
plt.plot(white_noise[:200], label="White Noise Samples")
plt.axhline(0, color='r', linestyle='--', label="Mean = 0")
plt.title("First 100 White Noise Samples")
plt.legend()

# Subplot 2: Running average
plt.subplot(2, 1, 2)
plt.plot(cumulative_mean, label="Running Average", color='orange')
plt.axhline(0, color='r', linestyle='--', label="Mean = 0")
plt.title("Running Average of White Noise")
plt.legend()

plt.tight_layout()
plt.show()

# Calculate the overall average of the white noise
average = np.mean(white_noise)
print(f"The overall average of the white noise is: {average}")

