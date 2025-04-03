#!/bin/bash

#
package=${1}
ID=${UID}
STATUS=${?}
#

help() {
	echo "installer -i or --info for info about the script"
	echo "installer [package_name] to install a package"
}

info() {
	echo "
This is a script that can be used to
install packages either using the nala or apt
package without entering the hole command for
installation if you are a lazy command person.
The script will detect if you need sudo or not
to install the package, and also if you have nala
already because it's the default package that will
be used for the installation, if not the script will
use apt as the default package, feel free to modify
the script if you want. LONG LIFE FOR OPEN SOURCE CODE!!
"
}

net_check() {
	if ! ping -c 3 -W 1 ubuntu.com &>/dev/null;
	then
		echo "Network error!"
		exit 1
	fi
}

case ${1} in
	-h | --help)
		help
		exit 0
		;;
	-i)
		info
		exit 0

esac

if [[ -z ${package} ]];
then
	echo "Invalid entry, you must provide a package name!"
	echo "Try: installer -h or --help"
	exit 1
elif [[ ${#} -gt 1 ]];
then
	echo "You can provide only one argument."
	echo "You provided ${#} arguments."
	exit 1

else
	net_check
	if ! command -V nala &>/dev/null;
	then
        	echo "Switching to apt package."
        	sleep 2	
		if [[ ${ID} == 1000 ]];
		then
			sudo apt-get install "${package}" -y
			if [[ ${STATUS} == 0 ]];
			then
				exit 0
			else
				exit 1
			fi
		else
			apt-get install "${package}"      -y
			if [[ ${STATUS} == 0 ]];
			then
				exit 0
			else
				exit 1
			fi
		fi
	else
		if [[ ${ID} == 1000 ]];
		then
			sudo nala install "${package}" -y 2> /dev/null
	        	if [[ ${STATUS} == 0 ]];
                	then
                	        exit 0
                	else
                	        exit 1
                	fi

		else
			nala install "${package}" -y 2> /dev/null
                	if [[ ${STATUS} == 0 ]];
                	then
                        	exit 0
               	 	else
                        	exit 1
                	fi
		fi
	fi
fi
