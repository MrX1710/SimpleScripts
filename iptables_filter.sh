#!/bin/bash
#A simple script that will manage filter table of iptables
#Maybe you don't know but iptables have 5 different tables
#Each one manages specefics rules
#This one is as i said for the filer table only

##Variables
##
ID=${UID}
STATUS=${?}
FLAG_FILE=/home/${USER}/flag_file.txt
##

keyboard_interruption() {
	echo -e "\n\e[1mProgram interrupted\e[0m"
	exit 1
}
trap keyboard_interruption SIGINT

#I'm gonna set up a list of rules that i think are necessary
#then i'm gonna set INPUT policy as DROP
#i'm gonna comment the function in the code so if you want to set
#theses rules just uncomment it, and it'll run only one time.

default_rules() {
	iptables -I INPUT 1 -i lo -j ACCEPT
	iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
	iptables -A INPUT -p tcp --dport 80 -j ACCEPT
	iptables -A INPUT -p tcp --dport 443 -j ACCEPT
	iptables -A INPUT -p tcp --dport 23 -j DROP
	iptables -A INPUT -p tcp --dport 445 -j DROP
	iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
	iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
	iptables -A OUTPUT -p tcp --dport 23 -j DROP
	iptables -A OUTPUT -p tcp --dport 445 -j DROP

	#If you don't use ssh i recommand you to uncomment theses ones
	# iptables -A INPUT -p tcp --dport 22 -j DROP
	# iptables -A OUTPUT -p tcp --dport 22 -j DROP

	if [[ ! -f ${FLAG_FILE} ]];
	then
		touch ${FLAG_FILE}
		echo "This is the flag file from iptables script, don't remove it" > ${FLAG_FILE}
		iptables -P INPUT DROP
	else
		exit 0
	fi
}

CHECK() {
	if [[ ${ID} != 0 ]];
	then
		echo -e "\e[1;31mYou are not allowed to run this script!"
		exit 1
	fi
}

APPEND_INSERT() {
	read -p "Do you want to append or insert a rule?[A/I]: " AI
}

CHECK

cat << EOF
    1) List iptables rules
    2) Flush iptables rules
    3) Delete iptables rules
    4) Append/Insert rules using port and dport (-p --dport)
    5) Append/Insert rules using source and destination source (-s -d)
    6) Append/Insert rules using source, d with port and dport
    7) Create a custom chain
    8) Rename a custom chain
    9) Delete a custom chain
   10) Set policy for a chain
EOF

if [[ ${ID} == 0 ]];
then
        #default_rules
	read -p "Make your choice: " choice
	case ${choice} in
		1)
			iptables -L -v
			;;
		2)
			iptables -F
			if (( ${STATUS} == 0 ));
			then
				echo "Rules flusehd"
				exit 0
			fi
			;;
		3)
			iptables -L --line-numbers
			read -p "Enter the chain name: " chain
			read -p "Enter the rule's number to delete: " rn
			iptables -D ${chain^^} ${rn} 2>/dev/null
			;;
		4)
			APPEND_INSERT
			read -p "Enter the chain name: " chain
			read -p "Enter the port name: " port
			read -p "Enter the destination port number: " dport
			read -p "Enter the target rule: " tr
			if [[ ${AI^^} == "A" ]];
			then
				iptables -A ${chain^^} -p ${port} --dport ${dport} -j ${tr^^}
			elif [[ ${AI^^} == "I" ]];
			then
				read -p "Enter the rule's position: " rp
				iptables -I ${chain^^} ${rp} -p ${port} --dport ${dport} -j ${tr^^}
			else
				exit 1
			fi
			;;
		5 | 6)
			APPEND_INSERT
			read -p "Do you want to add a destination?[Y/N]: " yn
			read -p "Enter the chain name: " chain
			read -p "Enter the ip source: " ip
			read -p "Enter the target rule: " tr

			if [[ ${AI^^} == "A" ]];
			then
				if [[ ${yn^^} == "Y" ]];
				then
					read -p "Enter the destination: " d
					iptables -A ${chain^^} -s ${ip} -d ${d} -j ${tr^^} 
				elif [[ ${yn^^} == "N" ]];
				then
					iptables -A ${chain^^} -s ${ip} -j ${tr^^}
				else
					exit 1
				fi

			elif [[ ${AI^^} == "I" ]];
			then
				read -p "Enter the rule's position: " rp
                                if [[ ${yn^^} == "Y" ]];
                                then
                                        read -p "Enter the destination: " d
                                        iptables -I ${chain^^} ${rp} -s ${ip} -d ${d} -j ${tr^^}
                                elif [[ ${yn^^} == "N" ]];
                                then
                                        iptables -I ${chain^^} ${rp} -s ${ip} -j ${tr^^}
                                else
                                        exit 1
                                fi
			else
				exit 1
			fi

			if (( ${choice} == 6 ));
			then
				read -p "Enter the port name: " port
				read -p "Enter the destination port: " dport
				if [[ ${AI^^} == "A" ]];
                                then
					if [[ ${yn^^} == "Y" ]];
                                        then
						read -p "Enter the destination: " d
                                                iptables -A ${chain^^} -s ${ip} -p ${port} -d ${d} --dport ${dport} -j ${tr^^}
                                        elif [[ ${yn^^} == "N" ]];
                                        then
					        iptables -A ${chain^^} -s ${ip} -p ${port} -d ${d} --dport ${dport} -j ${tr^^}
                                        else
						exit 1
		
					fi
				elif [[ ${AI^^} == "I" ]];
                                then
					if [[ ${yn^^} == "Y" ]];
					then
						read -p "Enter the destination: " d
					        read -p "Enter the rule's position: " rp
                                                iptables -I ${chain^^} ${rp} -s ${ip} -p ${port} -d ${d} --dport ${dport} -j ${tr^^}
                                        elif [[ ${yn^^} == "N" ]];
					then
                                                iptables -I ${chain^^} ${rp} -s ${ip} -p ${port} --dport ${dport} -j ${tr^^}
					else
						exit 1
					fi
				fi
			fi
			;;
		7)
			read -p "Enter the custom chain's name: " cchain
			iptables -N ${cchain^^}
			;;
		8)
			read -p "Enter the old chain's name: " ochain
			read -p "Enter the new chain's name: " nchain
			iptables --rename-chain ${ochain^^} ${nchain^^}
			;;
		9)
			read -p "Enter the custom chain's name you want to delete: " dcchain
			iptales -X ${dcchain^^}
			;;
		10)
			read -p "Enter the chain's name: " chain
			read -p "Enter the desired chain's policy: " policy
			iptables -P ${chain^^} ${policy^^}
			;;
		*)
			echo "Option not available"
			exit 1
	esac
fi
