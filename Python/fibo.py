#!/usr/bin/env python3
#
fibo_serie = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025, 121393, 196418, 317811, 514229] #Some of the fibonacci numbers
try:
    a = int(input("Enter a fibo number (a) > "))
    b = int(input("Enter a fibo number (b) > "))

    if a not in fibo_serie and  b not in fibo_serie:
        print("Both numbers are not in fibonacci list")
    elif a not in fibo_serie:
        print("Given number a is not in fibonacci list")
    elif b not in fibo_serie:
        print("Given number b is not in fibonacci list")
    else:
        try:
            if a < b:
                pass
            elif a == b:
                pass
            else:
                golden_ratio = (a + b) / a
                frac_a_b = a / b
                if round(golden_ratio, 1) == round(frac_a_b, 1):
                    print("\n")
                    print("**********************************************")
                    print(f" a as {a} and b as {b} have a golden ratio 𝛗")
                    print(f" (a+b)/a >> {golden_ratio}")
                    print(f" a/b >> {frac_a_b}")
                    print("**********************************************")

        except:
            pass
except:
    pass
#
