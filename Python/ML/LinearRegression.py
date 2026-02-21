#!/usr/bin/env python3
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, mean_absolute_error
import matplotlib.pyplot as plt
from colors import bold, green
IceCream = pd.read_csv('IceCreamData.csv')
print(bold(green("DATASET:")))
print(IceCream)
print(bold(green("\nDescribing the dataset:")))
print(IceCream.describe())
print(bold(green("\nInfo of the dataset:")))
print(IceCream.info())

#Defining the dependant and independant
x = IceCream[['Temperature']] #indp
y = IceCream['Revenue'] #dpnd

#model training
x_train, x_test, y_train, y_test = train_test_split(x,y, test_size=0.2, random_state=100)
model = LinearRegression(fit_intercept=True).fit(x_train,y_train)

#model's estimated parameters
print(bold(green("\nEstimated Parameters:")))
print(f"Intercept(alpha): {model.intercept_}")
print(f"Coefficient(beta): {model.coef_}")
print(f"Our Model: Revenue = {model.intercept_} + {model.coef_}*Temperature")


#predictions
y_pred_test = model.predict(x_test)
y_pred_train = model.predict(x_train)

#model's metrics
#train data
print(bold(green("\nPearson r:")))
print(f"r(train): {np.sqrt(model.score(x_train, y_train))}")
print(bold(green("\nCoefficient of determination:")))
print(f"R²(train): {model.score(x_train, y_train)}")
print("MAE(train):", mean_absolute_error(y_train, y_pred_train))
print("RMSE(train):", np.sqrt(mean_squared_error(y_train, y_pred_train)))
# Test data
print(bold(green("\nPearson r:")))
print(f"r(test): {np.sqrt(model.score(x_test, y_test))}")
print(bold(green("\nCoefficient of determination:")))
print(f"R²(test): {model.score(x_test, y_test)}")
print("MAE(test):", mean_absolute_error(y_test, y_pred_test))
print("RMSE(test):", np.sqrt(mean_squared_error(y_test, y_pred_test)))
print(bold(green("\nPredictions(y_pred)")))
print(y_pred_test)

#visualisation of the results
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

#visualisation of the errors
Residuals = y_test - y_pred_test
plt.figure(figsize=(8,8))
plt.scatter(y_pred_test, Residuals)
plt.axhline(y=0, color='red', linestyle="--")
plt.xlabel("Predicted Revenue")
plt.ylabel("Residuals")
plt.title("Residuals plotting")
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