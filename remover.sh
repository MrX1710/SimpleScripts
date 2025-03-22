#!/bin/bash
#
package=${1}
ID=${UID}
#

if [[ -z ${package} ]];
then
	echo "Invalid Entry!"

elif [[ ${#} -gt 1 ]];
then
	echo "Only one argument is required."
	echo "${#} were given."

else
	if [[ ${ID} == 1000 ]];
	then
		sudo nala remove "${package}" -y
	else
		nala remove "${package}" -y
	fi
fi
