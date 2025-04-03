#!/bin/bash

network_check() {
	if ! ping -c 1 -W 1 linux.com &> /dev/null;
	then
		echo "The network is down!"
		exit 1
	fi
}

command_check() {
	if ! command -v ifconfig &> /dev/null;
	then
		echo "ifconfig command not installed!"
		echo "Exiting with status code [1]"
		exit 1
	fi
	if ! command -v wget &> /dev/null;
	then
		echo "wget command not installed!"
		echo "Exiting with status code [1]"
		exit 1
	fi
        if ! command -v ip route &> /dev/null;
	then
                echo "ip route command not installed"
		echo "Exiting with status code [1]"
                exit 1
	fi
}
network_check
command_check

echo -e "Interface name: $(ifconfig | awk '{if (NR == 10) print $1}' | sed 's/://g')\n"

echo "Localhost : 127.0.0.1"
echo "Public IP : $(wget -qO- ifconfig.co)"
echo "Private IP: $(ifconfig | awk '{if (NR == 11) print $2}')"
echo "MAC addr  : $(ifconfig | awk '{if (NR == 12) print $2}')"
echo "Netmask   : $(ifconfig | awk '{if (NR == 11) print $4}')"
echo "Broadcast : $(ifconfig | awk '{if (NR == 11) print $6}')"
echo "Gateway   : $(ip route | awk '{if (NR == 1)  print $3}')"
