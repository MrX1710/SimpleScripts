#!/usr/bin/env python3
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt
from colors import bold, green
IceCream = pd.read_csv('IceCreamData.csv')
print(bold(green("DATASET:")))
print(IceCream)
print(bold(green("\nDescribing the dataset:")))
print(IceCream.describe())
print(bold(green("\nInfo of the dataset:")))
print(IceCream.info())

x = IceCream[['Temperature']]
y = IceCream['Revenue']

x_train, x_test, y_train, y_test = train_test_split(x,y, test_size=0.2, random_state=100)
model = LinearRegression(fit_intercept=True).fit(x_train,y_train)
print(bold(green("\nEstimated Parameters:")))
print(f"Intercept(alpha): {model.intercept_}")
print(f"Coefficient(beta): {model.coef_}")

print(bold(green("\nPearson r:")))
print(f"r(test): {np.sqrt(model.score(x_test, y_test))}")
print(f"r(train): {np.sqrt(model.score(x_train, y_train))}")

print(bold(green("\nCoefficient of determination:")))
print(f"R²(test): {model.score(x_test, y_test)}")
print(f"R²(train): {model.score(x_train, y_train)}")


y_pred = model.predict(x_test)
print(bold(green("\nPredictions(y_pred)")))
print(y_pred)

plt.scatter(x_train, y_train, color='purple')
plt.plot(x_train, model.predict(x_train), color='black')
plt.xlabel('Temperature')
plt.ylabel('Revenue')
plt.title('Rev vs Temp(train data)')
plt.show()

plt.scatter(x_test, y_test, color='blue')
plt.plot(x_test, model.predict(x_test), color='red')
plt.xlabel("Temperature")
plt.ylabel("Revenue")
plt.title("Rev vs Temp(test data)")
plt.show()

#Prediction
try:
    temp = float(input("\nEnter a temperature value >> "))
    temp = pd.DataFrame([[temp]], columns=['Temperature'])
    Revenue = model.predict(temp)
    print(f"Revenue: {Revenue}")
except ValueError as ve:
    print(ve)
except KeyboardInterrupt as ke:
    print(ke)