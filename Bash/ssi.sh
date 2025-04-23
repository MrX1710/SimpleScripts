#!/bin/bash

PACKAGE=${1}
STATUS=${?}
ID=${UID}

network_check() {
	if ! ping -c 3 -W 1 github.com &>/dev/null;
	then
		echo "The Network is down"
		exit 1
	fi
}

if [[ -z "${PACKAGE}" ]];
then
	echo "Invalid entry"
	exit 1
else
	if [[ $ID -eq 0 ]]; then
		network_check
                snap install "${PACKAGE}"
	else
	        network_check
	        sudo snap install "${PACKAGE}"
	fi
fi

	if [[ $STATUS -eq 0 ]]; then
		exit 0
	else
		echo -p "Something's wrong, add classic if asekd for that?[Y/N]?" clss
		if [[ $clss == "Y" || $clss == "y" ]]; then
			if [[ $ID -eq 0 ]]; then
				snap install --classic "${PACKAGE}"
			else
				sudo snap install --classic "${PACKAGE}"
			fi
		elif [[ $clss == "N" || $clss == "n" ]]; then
			echo -e "\e[1;31mAbort\e[0m"
		else
			exit
		fi
	fi
