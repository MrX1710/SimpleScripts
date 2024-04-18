#!/usr/bin/python3
import socket
from socket import gethostbyname
from socket import gethostbyaddr
import sys
import requests
import json
import colors
import subprocess

def IPTool():
      print("""
      1) Get ip of a random host
      2) Get the hostname of a random ip
      3) Get ip Location
      """)
      try:
       choice = input("Choose an option: ")
       if choice == "1":
            def get_ip():

                  try:
                        while True:
                              t_host = input("Enter the name of the host: ")
                              if t_host.isdigit():
                                    print(colors.green("Please provide a domain name!"))
                              elif t_host.strip() == "":
                                    print(colors.bold(colors.red("Invalid input!")))
                              else:
                                    hostname_ip = gethostbyname(t_host)
                                    print(f"IP adresse of the domain: {colors.bold(colors.green(hostname_ip))}")
                                    break
                  except socket.gaierror:
                        print(colors.bold(colors.red("Invalid domain name!")))  
                  except KeyboardInterrupt:
                        print(colors.bold("\nProgram Aborted"))
                        sys.exit()
            get_ip()

       elif choice == "2":
            def get_host():
                  try:
                        while True:
                              t_ip = input("Enter the ip of the host: ")
                              if t_ip.islower() or t_ip.isupper():
                                    print(colors.bold(colors.green("Please provide a numerical value!")))
                              elif t_ip.strip() == "":
                                    print(colors.bold(colors.red("Invalid input!")))
                              else:
                                    ip_hostname = gethostbyaddr(t_ip)
                                    print("Hostname: {}".format(ip_hostname).replace(", []", ''))
                                    break
                  except socket.herror:
                        print(colors.bold("Uknown host!"))
                  except socket.gaierror:
                        print(colors.bold(colors.red("DNS lookup failed!")))
                  except KeyboardInterrupt:
                        print(colors.bold("\nProgram Aborted"))
                        sys.exit()
            get_host()

       elif choice == "3":
            def get_ip_location():
                  try:
                        while True:
                              ip_addr = input("Enter an IP adresse: ")
                              if ip_addr.strip() == "":
                                    print(colors.bold(colors.red("Invalid input!")))
                              elif ip_addr.islower() or ip_addr.isupper():
                                    print(colors.bold(colors.green("Please provide a numerical value!")))
                              else:
                                    request = requests.get(f"https://ipinfo.io/{ip_addr}/json")
                                    if request.status_code != 200:
                                          print(colors.bold(colors.red("Connection error!")))
                                          sys.exit()
                                    else:
                                          response = request.json()
                                          ip_info = (
                                                f"Country   : {response['country']}",
                                                f"Location  : {response['region']}",
                                                f"City      : {response['city']}" 
                                          )
                                          for x in ip_info:
                                                print(x)
                                          break
                  except KeyboardInterrupt:
                        print(colors.bold("\nProgram Aborted"))
                        sys.exit()
            get_ip_location()

       else:
           sys.exit(colors.bold(colors.red("Invalid entry!")))
      except KeyboardInterrupt:
           print(colors.bold("\nProgram Aborted"))
           sys.exit()
IPTool()

while True:
      try:
            let_or_stop = input("Do you want to continue?[Y/N]: ")
            if let_or_stop.strip() == "":
                 print(colors.bold(colors.red("Invalid input!")))
                 continue
            if let_or_stop not in ["Y", "N"]:
                 print(colors.bold(colors.red(f"{let_or_stop} is uknown!")))
                 continue
            if let_or_stop == "Y":
                 subprocess.call('clear', shell=True)
                 IPTool()
            elif let_or_stop == "N":
                 sys.exit(colors.bold(colors.green("Program exited.")))
                 break
      except KeyboardInterrupt:
            print(colors.bold("\nProgram Aborted"))
            break
