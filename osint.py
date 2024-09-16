#!/usr/bin/env python3
#Simple osint script on domains

import subprocess
import socket
import dns.resolver
import whois
import sys
import requests

from colors import bold, red, green
from socket import gethostbyname

def net_check(target):
    #Checking if the user have a connection to run the script
    ping = subprocess.run(
            f"ping -c 1 -W 1 {target}",
            shell=True,
            stderr=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL
            )
    if ping.returncode == 0:
        return 0
    else:
        #sys.exit("Error!")
        sys.exit(bold(red("Error!")))
        sys.exit(1)


def get_ip(target):
    #Getting the target's IP addr
    try:
        IP = gethostbyname(target)
    except socket.gaierror:
        print("Invalid domain name!")

    #print("[IP]:\n" + IP)
    print(bold(green("[IP]:\n")) + IP)
    return IP

def get_servers_name(target):
    #Getting server's name and it's ip's of the target
    #print("\n[SERVERS]:")
    print(bold(green("\n[SERVERS]:")))
    try:
        servers = dns.resolver.resolve(target, "NS")
        for server in servers:
            print(f"{server} ----> ", end='')
            try:
                ip = dns.resolver.resolve(server.to_text(), 'A')
                for addr in ip:
                    print(addr)
            except dns.resolver.NoAnswer:
                print("IP NOT FOUND!")
    except dns.resolver.NoAnswer:
        print("No DNS response")
    except dns.resolver.NXDOMAIN:
        print("DNS query name does not exist")
    
def get_mx_records(target):
    #Getting mail exchanges records of the target
    #print("\n[MX RECORDS]:")
    print(bold(green("\n[MX RECORDS]:")))
    try:
        mxrs = dns.resolver.resolve(target, "MX")
        for mxs in mxrs :
            print(mxs)
    except dns.resolver.NoAnswer:
        print("No DNS response")
    except dns.resolver.LifetimeTimeout:
        print("Resolution lifetime expired")
    except dns.resolver.NXDOMAIN:
        print("DNS query name does not exist")
    

def get_whois_records(target):
    #Getting whois records of the target
    #print("\n[WHOIS RECORDS]:")
    try:
        print(bold(green("\n[WHOIS RECORDS]")))
        domain = whois.query(target)
        creation_date = domain.creation_date
        expiration_date = domain.expiration_date
        last_updated = domain.last_updated
        registrar = domain.registrar

        print(f"Creation date  : {creation_date}   ")
        print(f"Expiration date: {expiration_date} ")
        print(f"Last updated   : {last_updated}    ") 
        print(f"Registrar      : {registrar}       ")
    except Exception:
        print("None")

def get_target_status(target):
    #Getting the status of the target (up or down)
    #Not fullproof, the target can disable the ability 
    #to ping it's domain.
    #print("\n[STATUS]:")
    print(bold(green("\n[STATUS]:")))
    URL = f"https://www.{target}"
    try:
        response = requests.request(method='GET', url=URL)
        if response.status_code == 200:
            print("The host is up")
        else:
            print("The host is down!")
    except requests.exceptions.SSLError:
        print("The host is down")
    except requests.exceptions.ConnectionError:
        print("Could not get target's status")

def get_ip_info(ip):
    #Get ip info of the target
    #print("\n[IP INFO]:")
    print(bold(green("\n[IP INFO]:")))
    request = requests.get(f"https://ipinfo.io/{ip}/json")
    response = request.json()
    print(
            f"City    : {response['city'     ]}",
            f"Region  : {response['region'   ]}",
            f"Country : {response['country'  ]}",
            f"Timzeone: {response['timezone' ]}",
            f"Postal  : {response['postal'   ]}",
            f"Org     : {response['org'      ]}",
            sep = "\n"
    )

def port_scan(ip):
    #Getting the target's open ports
    print(bold(green("\n[PORTS]:")))
    subprocess.run(
            f"nmap -Pn {ip} | grep open", 
            shell=True, 
            stderr=subprocess.DEVNULL
            )

def main():
    try:
        target = input("Enter a target > ")

        if not target.strip() or target.isdigit():
            print(bold(red("Invalid entry!")))

        else:
            net_check(target)
            ip = get_ip(target)
            get_servers_name(target)
            get_mx_records(target)
            get_whois_records(target)
            get_target_status(target)
            get_ip_info(ip)
            port_scan(ip)
    except KeyboardInterrupt:
        print("\nAbort")

if __name__ == "__main__":
    main()
