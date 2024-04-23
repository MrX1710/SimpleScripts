from math import comb, pow, factorial, exp
from math import sqrt, pi
from fractions import Fraction
from scipy.integrate import quad
import scipy.stats as stats
import sys
import subprocess
def nve(): # (nve: negative_values_error)in case tha values given were negatives, which should not be so in probability.
    print("Please enter only positive numbers!")

def Probability():
 print("1)Bernouli", end="\t")
 print("2)Binomial")
 print("3)Poisson", end="\t")
 print("4)Geometrical")
 print("5)H-Geometrical", end="\t")
 print("6)Natural(Z)")
 print("7)Exponential", end="\t")
 print("8)Uniform")
 try:
    choice = int(input("Choose a distribution: "))
    if choice == 1:
        def Bernouli():
            try: 
                p = float(input("\nEnter p value: "))
                q = float(input("Enter q value: "  ))
                x = int(input("Enter x value: "    ))
                g_values = [p, q, x] #given_values
                if any(x < 0 for x in g_values):
                    nve()
                if x > 1:
                    print("x should be 1 <= x <= 0")
                else:
                    bernouli_d = pow(p, x) * pow(q, 1-x)
                    print(f"Probability: {bernouli_d * 100:.2f}%")
            except ValueError as ve:
                print(ve)
            except KeyboardInterrupt:
                print("\n\nAbort")
        Bernouli()

    elif choice == 2:
        def Binomial():
            try:
                p = float(input("\nEnter p value: "))
                q = float(input("Enter q value: "  ))
                n = int(input("Enter n value: "    ))
                x = int(input("Enter x value: "    ))
                g_values = [p, q, n, x]
                if any(x < 0 for x in g_values):
                    nve()
                elif n < x:
                    print("Error! n should be greater than x!")
                elif n > 30 and p < 0.1:
                    print("p is too small")
                    print("n is greater than 30")
                    print("Using the poisson and binomial relation:")
                    λ = n * p
                    pbr = (exp(-λ)/factorial(x)) * pow(λ, x)
                    print(f"Probability: {pbr * 100:.2f}%")
                else:
                    binomial_d = comb(n,x) * pow(p, x) * pow(q, n-x)
                    print(f"Probability: {binomial_d * 100:.2f}%")
            except ValueError as ve:
                print(ve)
            except KeyboardInterrupt:
                print("\nAbort")
        Binomial()

    elif choice == 3:
        def Poisson():
            try:
                λ = float(input("\nEnter lambda value: "))
                x = int(input("Enter x value: "         ))
                if λ < 0 or x < 0:
                    nve()
                else:
                    poisson_d = (exp(-λ)/factorial(x)) * pow(λ, x)
                    print(f"Probability: {poisson_d * 100:.2f}%")
            except ValueError as ve:
                print(ve)
            except KeyboardInterrupt:
                print("\nAbort")
        Poisson()

    elif choice == 4:
        def Geometrical():
            try:
                p = float(Fraction(input("\nEnter p value: ")))
                q = float(Fraction(input("Enter q value: "  )))
                k = int(input("Enter k value: "              ))
                g_values = [p, q, k]
                if any(x < 0 for x in g_values):
                    nve()
                else:
                    geometrical_d = p * pow(q, k-1)
                    print(f"Probability: {geometrical_d * 100:.2f}%")
            except ValueError as ve:
                print(ve)
            except KeyboardInterrupt:
                print("\nAbort")
        Geometrical()

    elif choice == 5:
        def Hyper_Geometrical():
            try:
                N = int(input("\nEnter N value: "))
                n = int(input("Enter n value: "  ))
                r = int(input("Enter r value: "  ))
                x = int(input("Enter x value: "  ))
                g_values = [N, n, r, x]
                if any(x < 0 for x in g_values):
                    nve()
                if r < x and N < n:
                    print("Error! r should be greater than x")
                    print("Error! N should be greater than n")
                elif N < n:
                    print("Error! N should be greater than n")
                elif r < x:
                    print("Error! r should be greater than x")
                else:
                    Hyper_Geometrical_d = (comb(r, x) * comb(N-r, n-x)) / comb(N, n)
                    print(f"Probability: {Hyper_Geometrical_d * 100:.2f}%")
            except ValueError as ve:
                print(ve)
            except KeyboardInterrupt:
                print("\nAbort")
        Hyper_Geometrical()

    elif choice == 6:
        def Natural_Z():
            try:
                x = int(input ("\nEnter x value: "     ))
                µ = int(input ("Enter mean value: "    ))
                𝜎 = float(input("Enter sigma value: "  ))
                g_values = [x, µ, 𝜎]
                if any(x < 0 for x in g_values):
                    nve()

                S_O_G = input("Standard or General Z formula?: ")
                if S_O_G.strip() == "":
                    print("Invalid Input")
                if S_O_G.isdigit():
                    print("Error! should be str value only!")

                if S_O_G == "Standard":
                    Z = (x-µ)/𝜎
                    Z_score = stats.norm.cdf(Z)
                    positive_table_value = 1 - Z_score
                    negative_table_value = Z_score
                    z_table = input("Positive, negative or else Z values?[p/n/e]: ") 
                    #The choice of positive or negative despite the else value being also positive, are made just
                    #when your z_score is negative like: P(Z<-2) or even if positive but will require to substract 1 like P(Z>z)
                    #I inserted an else option as e in case the result is not negative or even if it was not but requires substratting 1 like i said
                    #Because we need to get the probability of a z_score in case it is just positive which means
                    #just P(Z<z) assuming that it's results is a positive one.
                    if z_table == "p":
                        if Z < 0:
                            positive_table_value2 = 1 - positive_table_value
                            print(f"Probability: {positive_table_value2 * 100:.2f}%")
                        else:
                            print(f"Probability: {positive_table_value * 100:.2f}%")
                    elif z_table == "n":
                        print(f"Probability: {negative_table_value * 100:.2f}%")
                    elif z_table == "e":
                        positive_table_value = Z_score
                        print(f"Probability: {positive_table_value * 100:.2f}%")
                    else:
                        print("Error! choose p, n or e !")

                elif S_O_G == "General":
                    Z = (x-µ)/𝜎
                    Z = (1/(𝜎 * sqrt(2 * pi)) * exp(-1/2 * pow(Z, 2)))
                    print(f"Probability: {Z * 100:.2f}%")
                else:
                    print("Error! enter Standard or General !")
            except ValueError as ve:
                print(ve)
            except KeyboardInterrupt:
                print("\nAbort")
        Natural_Z()

    elif choice == 7:
        def Exponential():
            def exp_function(x):
                return λ * exp(-λ * x)
            try:
                λ = Fraction(input("\nEnter lambda value: "  ))
                a = int(input("Enter a value: "                   ))
                b = int(input("Enter b value: "                   ))
                g_values = [λ, a, b]
                if any(x < 0 for x in g_values):
                    nve()
                exponential_d, err = quad(exp_function, a, b)
                print(f"Probability of the integration from {a} to {b} is: {exponential_d * 100:.2f}%")
            except ValueError as ve:
                print(ve)
            except KeyboardInterrupt:
                print("\nAbort")
        Exponential()

    elif choice == 8:
        def Uniform():
            def f(x):
                return u_fx
            try:
                u_fx = Fraction(input("Enter the uniform function: "         ))
                a_intg = int(input("Enter a value for integration: "        ))
                b_intg = int(input("Enter b value for integration: "        ))
                a2_intg = int(input("Enter second a value for integration: "))
                b2_intg = int(input("Enter second b value for integration: "))
                g_values = [u_fx, a_intg, b_intg, a2_intg, b2_intg]
                if any(x < 0 for x in g_values):
                    nve()
                if a_intg > b_intg or a2_intg > b2_intg:
                    print("Error! results to negative value!\nreminder:a∫b = F(b) - F(a)")
                integ1, err = quad(f, a_intg, b_intg)
                integ2, err = quad(f, a2_intg, b2_intg)
                uniform_d = integ1 + integ2
                print(f"Probability of the integration from {a_intg} to {b_intg} and from {a2_intg} to {b2_intg} is: {uniform_d:.2f}%")
            except ValueError as ve:
                print(ve)
            except KeyboardInterrupt:
                print("\nAbort")
        Uniform()

    else:
        print("Choice not available!")
 except ValueError as ve:
    sys.exit(ve)
 except KeyboardInterrupt:
    sys.exit("\nAbort")
Probability()

while True:
    try:
        s_o_c = input("Do you want to continue?[Y/N]: ")
        if s_o_c == "Y":
            subprocess.call('clear', shell=True)
            Probability()
        elif s_o_c == "N":
            sys.exit("Program stopped.")
        else:
            print("Error! Enter Y or N!")
            continue
    except KeyboardInterrupt:
        sys.exit("\nAbort")
