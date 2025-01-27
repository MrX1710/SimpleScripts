#update script using nala in python

#!/usr/bin/env python3

import subprocess
import time
import os
import sys as s
from os import system as sys
from os import getuid as uid
from colors import red,green,bold

ID = uid()

def network_check():
    ping = subprocess.run("ping -c 3 -W1 archive.ubuntu.com", shell=True, 
                   stderr=subprocess.DEVNULL,
                   stdout=subprocess.DEVNULL
                   )
    if ping.returncode == 0:
        print(bold(green("Network: OK")))
        time.sleep(2)
    else:
        s.exit(bold(red("Network: not available")))
        s.exit(1)


def is_installed():
    if not os.path.exists("/usr/bin/nala"): #checkng if nala command has a binary file in /usr/bin
        s.exit(bold(red("Nala package not installed!\ninstall it by using apt install nala")))
    else:
        print(bold(green("Nala package found!")))

def ua(): #upgrade asking
    x = input("Anything to upgrade?[Y/N]: ")
    if ID == 0:
        if (x == "Y" or x == "y"):
            sys("nala upgrade -y")
        elif (x == "N" or x == "n"):
            s.exit(bold(red("Abort")))
        else:
            s.exit(bold(red("Abort")))
    else:
        if (x == "Y" or x == "y"):
            sys("sudo nala upgrade -y")
        elif (x == "N" or x == "n"):
            s.exit(bold(red("Abort")))
        else:
            s.exit(bold(red("Abort")))

def updater():
    network_check()
    #is_installed()
    time.sleep(2)
    if ID == 0: #root user
        print(bold(red("You are running this script as root")))
        subprocess.run("nala update", shell=True, stderr=subprocess.DEVNULL)
        ua()
    else: #any user other than root
        print(bold(red("You are running this script as non-root")))
        subprocess.run("sudo nala update", shell=True, stderr=subprocess.DEVNULL)
        ua()

def main():
    try:
        updater()
    except KeyboardInterrupt:
        s.exit(bold(red("Abort")))

if __name__ == "__main__":
    main()
