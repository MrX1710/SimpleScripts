#!/usr/bin/env python3

#i'm going to try making a payement handling (just saw it in a website (CodeForge), and based
#on what i saw i'm just gonna recreate something similar, and do some changes)
#i made some research and asked AI also (gemini, claude)
#okay so if i'm not wrong: the payement sys got is a 3 layer sys (obviously it variates idk everyhting on that but it does works also through theses steps) 
#justy like the osi model having 7 layers
#we generally go from top to bottom, showing the user
#the familiar layers he's intercating with directly first (7th layer application layer)
#until we arrive to the first foundation that supports this last one or we can say the base (1st layer physical layer)

#Layer 3 :The Interface through which users interacts with (cards, wallets)
#Layer 2: The core or the system that handles the operations such transactions, moving money, recording transactions
#Layer 1: The data holder layer, this is what stores and handles the data of users, in other words our DataBase

from abc import ABC, abstractmethod
from datetime import datetime
from dataclasses import dataclass, field
from enum import Enum

#i discovered that floats are dangerous in the case of payement systems :), 0.3 + 0.1 isn't 0.4 but 0.40000000000000004 (binary float-point arithmetic operation)
#now this is just for a simple value as 0.3 and 0.1
#what about millions? missing thousands of x currency
from decimal import Decimal

#this is the layer 1, or the data handeler
@dataclass
class Users:
    name : str
    uid : int
    balance : Decimal

class TransactionStatus(Enum):
    PENDING = "PENDING"
    FAILED = "FAILED"
    SUCCESS = "SUCCESS"

@dataclass
class Transactions:
    transaction_id : int
    sender_id : int
    receiver_id : int
    amount : Decimal
    status : TransactionStatus
    timestamp: datetime = field(default_factory=datetime.now)
    #at first i defined my timestamp as timestamp = datetime.now()
    #the problem with this is that it doesn't update, it gets one execution only
    #so a client making the first transaction at 9:00PM, The program executes and then it doesn't update to a new time, a second,third,..., n client will have it's transaction registered at the same timestamp as the first one.

#Layer2: The core

class PaymentSys:
    def __init__(self):
        self._users: dict[int, Users] = {}
        self._transactions : list[Transactions] = [] #making the Transactions class a list and then defaulting it to an empty one
        self._next_uid = 1
        self._next_tx = 1 #tx = transaction

    def CreateUser(self, name:str, initial_balance: Decimal = 0.0) -> Users: #return's Users object
        user = Users(name = name, uid=self._next_uid, balance = initial_balance)
        self._users[self._next_uid] = user
        self._next_uid += 1
        return user

    def _GetUser(self, uid:int) -> Users: #Retreive users based on id, nobody should access this except the system's staff or any other responsible on it
        if uid not in self._users:
            raise ValueError(f'{uid} not found')
        return self._users[uid] #searching by id is preferable, to avoid name errors
                                #or to avoid name duplications

    def PayementOperations(self, sender_id:int, receiver_id:int, amount:Decimal) -> Transactions:
        sender = self._GetUser(sender_id)
        receiver = self._GetUser(receiver_id)

        

        if amount <= 0:
            status = TransactionStatus.FAILED
        elif sender.balance < amount:
            status =TransactionStatus.FAILED
        else:
            sender.balance -= amount
            receiver.balance += amount
            status = TransactionStatus.SUCCESS
        tx = Transactions(self._next_tx, sender_id, receiver_id, amount, status)
        self._transactions.append(tx)
        self._next_tx += 1
        return tx

class PayementMethod(ABC): #could be a wallet or a card o any other payement methode
    def __init__(self):
        pass
    @abstractmethod
    def pay(self):
        pass
    @abstractmethod
    def send(self):
        pass