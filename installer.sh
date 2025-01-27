#!/bin/bash 

package=${1}
status_code=${UID}

help() {
	echo "installer -i or --info for info about the script"
	echo "installer [package_name]"
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
be used for the installation, if not then the script will
use apt as the default package.
"
}

if [[ -z ${package} ]];
then
	echo "Invalid entry, you must provide a package name!"
	echo "Try: installer -h or --help"
	exit 1
elif [[ ${#} > 1 ]];
then
	echo "You can provide only one argument."
	echo "You provided ${#} arguments."
	exit 1

elif [[ ${1} == "-h" || ${1} == "--help" ]];
then
        help
	exit 0

elif [[ ${1} == "-i" || ${1} == "--info" ]];
then
        info
	exit 0

else
	if [[ ${status_code} == 1000 ]];
	then
		sudo nala install ${package} -y 2> /dev/null
	        if [[ ${?} == 0 ]];
                then
                        exit 0
                else
                        exit 1
                fi

	else
		nala install ${package}      -y 2> /dev/null
                if [[ ${?} == 0 ]];
                then
                        exit 0
                else
                        exit 1
                fi
	fi
fi

if ! command -v nala &> /dev/null;
then
	echo "Default package nala was not found."
        sleep 2
        echo "Switching to apt repository."
        sleep 2	
	if [[ ${status_code} == 0 ]];
	then
		apt install ${package} -y 2> /Dev/null
		if [[ ${?} == 0 ]];
		then
			exit 0
		else
			exit 1
		fi
	else
		sudo apt install ${package}      -y 2>/dev/null
		if [[ ${?} == 0 ]];
		then
			exit 0
		else
			exit 1
		fi
	fi
fi
