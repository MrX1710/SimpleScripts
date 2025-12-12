#!/usr/bin/env python3
import datetime as dt
import yfinance as yf
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from mplfinance.original_flavor import candlestick_ohlc

#Start and end datetime
def date_check(SED): #SED= Start, End date
    while True:
        date = input(f"Enter the {SED} date (format Y,M,D) >> ")
        if "," in date:
            n = date.split(",") #in case you insert ,
        else:
            n = date.split() #in case you don't insert ","
        if len(n) != 3:
            print("You should enter 3 integer variables (year, month, day)")
            continue
        if not all(p.strip().isdigit() for p in n): #i check if the year, month and day are int
            print("Only integers allowed!")
        else:
            try:
                year,month,day = map(int, n) #i make the year month day variables, then make them integers, as the n contained a list of strings
                if year < 2000: #seted the start year from 2000
                    print("Enter year from 2000 and up")
                    continue
                else:
                    d = dt.datetime(year, month, day)
                    return d
            except Exception as exc:
                print(exc)
                continue
        break

start_date = date_check("start")
end_date = date_check("end")
while True:
    tickers = [
            "AAPL", "MSFT", "GOOGL", "AMZN", "TSLA",
            "META", "NVDA", "NFLX", "ADBE", "PYPL",
            "INTC", "CSCO", "ORCL", "CRM", "IBM",
            "AMD", "QCOM", "TXN", "SBUX", "BA"
            ] #This list was generated using gpt, i got lazy writing the tickers one by one.

    ticker = input("Enter a ticker >> ").upper()
    if not ticker.strip() or ticker not in tickers: #if you enter without inserting any 
        print("Enter one of the predefined tickers in the list")
        continue
    break
       
data_frame = yf.download(f'{ticker}', start=start_date, end=end_date, auto_adjust=False)
data_frame = data_frame[['Open', 'High', 'Low', 'Close']]
data_frame.reset_index(inplace=True)
data_frame['Date'] = data_frame['Date'].map(mdates.date2num)

#Ploting
ohlc = data_frame[['Date', 'Open', 'High', 'Low', 'Close']]
ax = plt.subplot(title='Stocks Data')
ax.grid(True)
ax.set_axisbelow(True)
ax.set_facecolor('black')
ax.figure.set_facecolor('black')

ax.tick_params(axis='x', colors='white')
ax.tick_params(axis='y', colors='white')

ax.xaxis_date()
candlestick_ohlc(ax, ohlc.values, width=0.5, colorup='#00ff00')
plt.show()