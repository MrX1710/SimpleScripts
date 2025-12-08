#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import tkinter as tk
from tkinter import ttk

# Try importing sounddevice (optional audio playback)
try:
    import sounddevice as sd #This library works with another library called PortAudio, make sure to have it as sounddevice depends on it.
    AUDIO_AVAILABLE = True
except ImportError:
    AUDIO_AVAILABLE = False

# ---------- SETTINGS ----------
duration = 2.0       # seconds
sample_rate = 44100  # Hz
N = int(duration * sample_rate)

# ---------- WHITE NOISE ----------
white_noise = np.random.normal(0, 1, N)

# ---------- PINK NOISE ----------
def generate_pink_noise(n_samples):
    rows = 16
    array = np.random.randn(rows, n_samples)
    pink = np.zeros(n_samples)
    for i in range(rows):
        step = 2 ** i
        pink += np.repeat(array[i][:n_samples // step + 1], step)[:n_samples]

    pink /= np.max(np.abs(pink))
    return pink

pink_noise = generate_pink_noise(N)

# ---------- BROWN NOISE ----------
brown_noise = np.cumsum(np.random.normal(0, 1, N))
brown_noise /= np.max(np.abs(brown_noise))

# ---------- TIME AXIS ----------
time = np.linspace(0, duration, N)

# ---------- PLOTTING FUNCTION ----------
def show_plot():
    plt.figure(figsize=(12, 7))
    plt.subplot(3, 1, 1)
    plt.plot(time[:2000], white_noise[:2000])
    plt.title("White Noise (zoomed)")

    plt.subplot(3, 1, 2)
    plt.plot(time[:2000], pink_noise[:2000])
    plt.title("Pink Noise (1/f)")

    plt.subplot(3, 1, 3)
    plt.plot(time[:2000], brown_noise[:2000])
    plt.title("Brown Noise (1/f²)")

    plt.tight_layout()
    plt.show()


# ---------- PLAYBACK FUNCTIONS ----------
def play_white():
    sd.play(white_noise, sample_rate)

def play_pink():
    sd.play(pink_noise, sample_rate)

def play_brown():
    sd.play(brown_noise, sample_rate)

def stop_sound():
    if AUDIO_AVAILABLE:
        sd.stop()


# ---------- GUI ----------
root = tk.Tk()
root.title("Noise Generator")

ttk.Label(root, text="Noise Generator", font=("Arial", 16)).pack(pady=10)

# Show Plot Button
ttk.Button(root, text="Show Noise Plots", command=show_plot).pack(pady=10)

# Audio Buttons Frame
frame = ttk.Frame(root)
frame.pack(pady=10)

# Create play buttons; disable if audio unavailable
btn_white = ttk.Button(frame, text="Play White Noise", command=play_white)
btn_white.grid(row=0, column=0, padx=5)

btn_pink = ttk.Button(frame, text="Play Pink Noise", command=play_pink)
btn_pink.grid(row=0, column=1, padx=5)

btn_brown = ttk.Button(frame, text="Play Brown Noise", command=play_brown)
btn_brown.grid(row=0, column=2, padx=5)

btn_stop = ttk.Button(frame, text="Stop", command=stop_sound)
btn_stop.grid(row=1, column=1, pady=10)

# Disable audio buttons if no library found
if not AUDIO_AVAILABLE:
    btn_white.state(['disabled'])
    btn_pink.state(['disabled'])
    btn_brown.state(['disabled'])
    btn_stop.state(['disabled'])

    ttk.Label(root, text="Audio playback not available (sounddevice not installed).",
              foreground="red").pack(pady=10)

root.mainloop()