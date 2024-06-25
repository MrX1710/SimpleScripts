#!/bin/bash 

#
PACKAGE=${1}
ARGS=${#}
STATUS=${?}
ID=${UID}
#

#Defining a net checker using ping
net_check() {
	if ! ping -c 3 -W 1 ubuntu.com &>/dev/null;
	then
		echo "Error!"
		exit 1
	fi
	}

#Conditions:
#1st one checking if the user leave the 1 psotional arg empty
if [[ -z ${PACKAGE} ]];
then
	echo "Invalid Entry!"
#2nd one checking if the user enters more than just one arg
elif [[ ${ARGS} -gt 1 ]];
then
	echo "Error, maximum args is 1"
	echo "You entered ${ARGS} args"

#If neither the 1st nor the 2nd occures then the script
#executes the commands bellow starting by checking the
#connection by using the function
else
	net_check
	if [[ ${ID} == 0 ]];
	then
		snap refresh ${PACKAGE}
	else
		sudo snap refresh ${PACKAGE}
	fi
	
	if [[ ${STATUS} -ne 0 ]];
	then
		exit 1 
	else
		exit 0
	fi

	#^checking if the refresh operation succeeds or not
fi
