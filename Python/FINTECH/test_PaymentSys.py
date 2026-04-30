from PaymentSys import *
sys = PaymentSys()

Alice  = sys.CreateUser("Alice", 2000)
Bob = sys.CreateUser('Bob', 500)

Alice_w = Wallet(Alice, sys)
Bob_w = Wallet(Bob, sys)

try:
    alice_wth = Alice_w.withdraw(500)
    tx = alice_wth
    print(f"\nTransaction #{tx.transaction_id}: {tx.status.value} at {tx.timestamp}")
    print(Alice_w.wallet_info())
except ValueError as ve:
    print(ve)

try:
    Alice_depo = Alice_w.deposit(1000)
    tx = Alice_depo
    print(f"\nTransaction #{tx.transaction_id}: {tx.status.value} at {tx.timestamp}")
    print(Alice_w.wallet_info())
except ValueError as ve:
    print(ve)

try:
    Alice_pay = Alice_w.pay(Bob_w, 1200)
    tx = Alice_pay
    print(f"\nTransaction #{tx.transaction_id}: {tx.status.value} at {tx.timestamp}")
    print(Alice_w.wallet_info())
except ValueError as ve:
    print(ve)

try:
    Alice_depo = Alice_w.deposit(856.459)
    tx = Alice_depo
    print(f"\nTransaction #{tx.transaction_id}: {tx.status.value} at {tx.timestamp}")
    print(Alice_w.wallet_info())
except ValueError as ve:
    print(ve)

print(Alice.uid)

try:
    print(sys._GetUser(George.uid))
except ValueError as ve:
    print(ve)
except NameError as ne:
    print(ne)

try:
    print(sys._GetUser(Bob.uid))
except ValueError as ve:
    print(ve)
except NameError as ne:
    print(ne)