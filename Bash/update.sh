#!/bin/bash

check_connection() {
	if ! ping -c 1 -W 1 archive.ubuntu.com >/dev/null 2>&1;
	then
		echo "Network Error!"
		exit 1
	fi
}
check_connection

while [ true ]
do
        if ! command -v nala &> /dev/null;
        then
		echo "This script uses nala as the default repository."
	 	echo "Nala repository not found!"
                echo "try: sudo apt install nala"
                break
	else
		sudo nala update 2> /dev/null
		read -p "Anything to upgrade[Y/N]?: " updt
		if [[ -z $updt  ]];
		then
			echo -e "\e[1mAbort \e[0m"
                        break
		fi
		if [[ $updt == "y" || $updt == "Y" ]];
		then
			echo -e "\e[1mUpgrade \e[0m"
                        sudo nala upgrade -y 2> /dev/null
			break
                        
			if [[ ${?} == 0 ]];
			then
				echo "Operation finished with success!"
				exit 0
			else
				echo "An error occured!"
				exit 1
			fi
			break

                elif [[ $updt == "n" || $updt == "N" ]];
		then
			echo -e "\e[1mNo upgrade \e[0m"
			break
                else
			echo -e "\e[1mAbort \e[0m"
			break
		fi
	fi
done
