#!/usr/bin/env python3

#Simple and geometric Random Walk process
#first test

import numpy as np
import matplotlib.pyplot as plt

def Plotter(prices, Plot_Title):
    plt.plot(prices)
    plt.title(Plot_Title)
    plt.xlabel("Days")
    plt.ylabel("Prices")
    plt.grid(True)
    plt.show()

def Simple_Random_Walk(n, S0):

    #St+1 = S_0 + €_t
    steps = np.random.normal(loc=0,scale=1,size=n) # mean=0, std=1
    prices = S0 + np.cumsum(steps)
    prices = np.insert(prices, 0, S0)

    #Plotting
    Plot_Title =  "Simple Random Walk"
    Plotter(prices, Plot_Title)

def Geometric_Random_Walk(n, S0):

    #St+1 = S_0 * (1 + returns_t)
    returns = np.random.normal(loc=0, scale=0.01, size=n)
    prices = S0 * np.cumprod(1 + returns)
    prices = np.insert(prices, 0, S0)
    
    #Plotting
    Plot_Title =  "Geometric Random Walk"
    Plotter(prices, Plot_Title)

try:
    S0 = float(input("Enter the starting price >> "))
    n = int(input("Enter the n steps >> "))
except ValueError as VE:
    exit(VE)
Simple_Random_Walk(n, S0)
Geometric_Random_Walk(n, S0)