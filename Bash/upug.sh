#!/usr/bin/env bash

ID="$UID"

if [[ "$UID" == 0 ]];
then
	apt update
	PKG=$(apt-get -s upgrade | grep -c '^Inst')
	if [[ "$PKG" -gt 0 ]];
	then
		apt-get upgrade -y
	else
		echo -e "\e[1mNo packages available for upgrade\e[0m!"
	fi
else
	echo -e "\e[1;31mPermission Denied!"
fi
