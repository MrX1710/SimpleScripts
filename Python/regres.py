#Simple linear regression only

from math import sqrt
from colors import bold as b
import matplotlib.pyplot as plt

r = 0
sum_residuals = 0
sum_squared_residuals = 0
SSR = 0


#do not uncomment unless you already commented the lists bellow
# list_x = [1400,1600,1700,1875,1100,1550,2350,2450,1425,1700] #m²
# list_y = [245,312,279,308,199,219,405,324,319,255] #thousands of dollars

# The list in question:
# list_x = [1.02, 2.08, 2.89, 4.04, 5.32, 5.83, 7.26, 7.96, 9.11, 9.99] #values of x
# list_y = [1.15, 0.85, 1.56, 1.72, 4.32, 5.07, 5.00, 5.31, 6.17, 7.04] #values of y

list_x = []
list_y = []
list__x = [] #values of (x-moyenne_x)
list__y = [] #values of (y-moyenne_y)
list_xs = [] # values of (x-moyenne_x)²
list_ys = [] # values of (y-moyenne_y)²


#This part gives the user the freedom of choosing the input data of his choice instead of the ones that are declared above
#make sure to comment the data above in order to use this part so that no conflict between declared data and input data happens
while True:
    try:
        x = float(input("Enter x value >> "))
        list_x.append(x)
    except KeyboardInterrupt:
        print("\n")
        try:
            while True:
                y = float(input("Enter y value >> "))
                list_y.append(y)
        except KeyboardInterrupt:
            pass
        break

mean_x = sum(list_x)  / len(list_x) #sum(xi)/n
mean_y = sum(list_y) / len(list_y) #sum(yi)/n

for x in list_x:
    SSDx = x-mean_x #sum of deviation of x values
    SSDX = (x-mean_x) ** 2 #sum of squared deviation of x values
    list_xs.append(SSDX)
    list__x.append(SSDx)
for y in list_y:
    SSDy = y - mean_y #sum of deviation of y values
    SSDY = (y - mean_y) ** 2 #sum of squared deviation of y values
    list_ys.append(SSDY)
    list__y.append(SSDy)

for i in range(len(list__x)):
    result = list__x[i] * list__y[i] #result of values of (x-moyenne_x) * values of (y-moyenne_y)
    r += result

Sx = sqrt(sum(list_xs) / len(list_x))
Sy = sqrt(sum(list_ys) / len(list_y))
coefficient_of_relation = (r/len(list_x)) / (Sx * Sy) #معامل الإرتباط
beta = r / sum(list_xs)
alpha = mean_y - (beta*mean_x)
beta = round(beta, 6)
alpha = round(alpha, 6)

#calc beta and alpha to evaluate the linear regression model
print(f"\n∑Xi: {sum(list_x)}")
print(f"∑Yi: {sum(list_y)}")
print(f"𝐱__: {mean_x}") #moyenne des valeurs de x
print(f"𝘠__: {mean_y}") #moyenne des valeurs de y
print(f"∑(x-moyenne_de_x)² >> {sum(list_xs)}")
print(f"∑(y-moyenne_de_y)² >> {sum(list_ys)}")
print(f"∑(x-moyenne_de_x)*(y-moyenne_de_y) >> {r}")
print(f"Sx = {Sx}")
print(f"Sy = {Sy}")
print(f"r(x,y) >> {coefficient_of_relation}\n")
#calc the t_calc value:
try:
    t_calc = coefficient_of_relation / sqrt((1-(coefficient_of_relation)**2) / (len(list_x) - 2))
    print(f"t_calc: {t_calc}")

    t_tab = float(input("Enter t_tab value >> "))
    if t_calc > t_tab:
        print("Accepting H1 due to the lack of enough data to accept H0(doesn't mean H0 is false)")
    elif t_calc == t_tab:
        pass
    else:
        print("Accepting H0 due to the lack of enough data to accept H1(doesn't mean H1 is false)\n")

    #calc the estimated errors and their squared values
    print(b("\nsum of estimated errors"))
    for j in range(len(list_x)):
        residuals = list_y[j] - (alpha + (beta*list_x[j]))
        print(f"{j+1} >> {list_y[j]} - ({alpha} + ({beta} * {list_x[j]})) = {residuals}")
        sum_residuals += residuals
    print(b(f"∑ei: {float(sum_residuals)}"))
    print(b("\nsum of squared estimated errors"))

    for k in range(len(list_x)):
        residuals = (list_y[k] - (alpha + (beta*list_x[k])))**2
        sum_squared_residuals += residuals #SSE
        print(f"{k+1} >> ({list_y[k]} - ({alpha} + ({beta} * {list_x[k]})))**2 = {residuals}")
    print(b(f"∑(ei)²: {sum_squared_residuals}"))
except:
    pass

#calc the standard error of beta (la pente, الميل)
Sxy = sqrt(sum_squared_residuals / (len(list_x) - 2))
print(f"Sxy: {Sxy}")
S_Bi = Sxy / sqrt(sum(list_xs)) #S(B^)
print(f"S(Bi): {S_Bi}")
t__calc =  beta / S_Bi

print(f"t calc beta: {t__calc}")

#SSE Already calculated
#Calc SSR = ∑(y^ - mean_y)², SST = SSE + SSR
for w in range(len(list_x)):
    sum_squared_regression = ((alpha + (beta*list_x[w])) - mean_y)**2
    # sum_squared_regression = sum_squared_regression**2
    SSR += sum_squared_regression
SSE = sum_squared_residuals
SST = SSR + SSE
print(f"\nSSE: {SSE}")
print(f"SSR {SSR}")
print(f"SST {SST}")

#Coefficient of determiination R² معامل التحديد
R_squared = SSR / SST
print(f"R²: {R_squared} ")
print(f"R² is {round(R_squared*100, 5)}%, it show that the x variables explains {round(R_squared*100, 5)}% of y's dependant variable changes")

#Adjusted R²
try:
    p = int(input("\nEnter the p value (number of variables): ")) #number of variables
except:
    pass
adj_R_squared = 1 - (((len(list_x)-1) / (len(list_x) - p - 1)) * (1-R_squared))
print(f"Adjusted R²: {adj_R_squared}") #معامل التحديد المصحح
print(f"R̅² is {round(adj_R_squared*100, 5)}%, it shows that the x variables beside the other variables that doesn't appear (included in ε) explains {round(adj_R_squared*100, 5)}% of y's dependant variable changes")

#Estimating the significance of the linear model
try:
    n = int(input("\nEnter the n value: "))
    F_tab = float(input("Enter F_tab value: "))
    F_calc = ((R_squared)/(n-1)) / ((1-R_squared)/(len(list_x)-n)) #n = k
    print(f"F_calc: {F_calc}")
    if F_calc > F_tab:
        print("Accepting H1 due to the lack of enough data to accept H0(doesn't mean H0 is false)")
    elif F_calc == F_tab:
        pass
    else:
        print("Accepting H0 due to the lack of enough data to accept H1(doesn't mean H1 is false)\n")
except:
    pass


def Linear_Regression_show():
    plt.scatter(list_x, list_y, color='black', label='Data Points')

    x_values = list_x
    y_values = [alpha + (beta*x) for x in x_values]

    plt.plot(x_values, y_values, color='red', label='Regression line')

    plt.title('Linear Regression')
    plt.xlabel('X values')
    plt.ylabel('Y values')

    plt.legend()

    plt.grid()
    plt.show()
Linear_Regression_show()

def Linear_Regression_Predictioon(new_x_values):
    predictions = []
    for x in new_x_values:
        predicted_y = alpha + (beta * x)
        predictions.append(predicted_y)

    plt.scatter(list_x, list_y, color='black', label='Data Points')
    y_values = [alpha + (beta * x) for x in list_x]
    plt.plot(list_x, y_values, color='red', label='Regression Line')
    plt.scatter(new_x_values, predictions, color='purple', label='Predicted Points', marker='x')

    plt.title('Linear Regression with Predictions')
    plt.xlabel('X values')
    plt.ylabel('Y values')

    plt.legend()
    plt.grid()
    plt.show()

new_x_values = [3.0, 4.5, 6.5]
Linear_Regression_Predictioon(new_x_values)