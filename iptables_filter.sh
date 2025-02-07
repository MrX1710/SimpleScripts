#!/bin/bash
## VARIABLES ##
ID=${UID}
STATUS=${?}
FLAG_FILE=/home/${USER}/flag_file
##

 ########################################
 # IPTABLE SCRIPT FOR FILTER TABLE ONLY #
 ########################################

#I'm gonna add these rules because i guess anyone will need them
#They have to be added first before setting
#INPUT chain policy as DROP
#else you'll block connexion for some components or let's say your browser or something else

default_rules() {
	iptables -I INPUT 1 -i lo -j ACCEPT
	iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
        iptables -A INPUT -p tcp --dport 80 -j ACCEPT
        iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
        iptables -A INPUT -p tcp --dport 443 -j ACCEPT
        iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
        sleep 2

        if ! [[ -f ${FLAG_FILE}  ]]; then #ensuring that this function runs one time only after first exec
		touch ${FLAG_FILE}
		echo "Hey, this file was created when you used the script, don't delete it or it'll execute the def rules function again" > ${FLAG_FILE}
	        iptables -P INPUT DROP
        else
		exit 1
	fi
}

STATUS_RULE_CHECK() {
	if [[ ${STATUS} -eq 0 ]];
	then
		echo "rule successfully added!"
        else
		echo "An error occured"
	fi
}

APPEND_INSERT_ASK() {
	read -p "Do you want to append or insert a rule?: " AIR
}

cat << EOF
    1) List iptables rules
    2) Flush iptables rules
    3) Delete iptables rules
    4) Append/Insert a rule using port and dport
    5) Append/Insert a rule using a source (IP ADDR)
    6) Append/Insert a rule using a source ( adding port and dport)
    7) Creating a custom chain
    8) Delete a custom chain    
EOF

if [[ ${ID} -eq 0 ]];
then
	#default_rules
	echo "\nRoot user detected"
	read -p "Make your choice: " choice
	case ${choice} in
		1)
			iptables -L
			;;
		2)
			iptables -F
			echo "Rules flushed"
			iptables -L
			;;
		3)
			iptables -L --line-numbers
			read -p "Enter the chain name: " chain 
			read -p "Choose the rule to delete: " dlr
			iptables -D ${chain} ${dlr}
			;;
		4)
			read -p "Enter the port: " port
		        read -p "Enter the dport (destination port): " dport
			read -p "Enter the chain name: " chain
			read -p "Enter the target rule: " tr
                        while [ true  ]
                        do
				APPEND_INSERT_ASK
			        if [[ ${AIR} == "A" ]];
				then
					iptables -A ${chain} -p ${port} --dport ${dport} -j ${tr}
					break
			        elif [[ ${AIR} == "I" ]];
			        then
					read -p "Enter the rule's position: " rp
			          	iptables -I ${chain} ${rp} -p ${port} --dport ${dport} -j ${tr}
					break
				else
					sleep 2
					continue
				fi
			done
				
		        ;;
		5)
			APPEND_INSERT_ASK
			read -p "Do you want to allow the source in a specified port or no?[Y/N]: " yn

			while [ true ]
			do
                                        read -p "Enter the chain name: " chain
                                        read -p "Enter the source ip: " ip
					read -p "Enter the target rule: " tr
				if [[ ${AIR} == "A" && ${yn} == "Y" ]];
				then
					read -p "Enter the source port: " sport
					iptables -A ${chain} -s ${ip} --sport ${sport} -j ${tr}
					break

				elif [[ ${AIR} == "A" && ${yn} == "N" ]];
				then
					iptables -A ${chain} -s ${ip} -j ${tr}
					break

				elif [[ ${AIR} == "I" && ${yn} == "Y" ]];
				then
					read -p "Enter the rule's position: " rp 
                                        read -p "Enter the source port: " sport
                                        iptables -I ${chain} ${rp} -s ${ip} --sport ${sport} -j ${tr}
					break

				elif [[ ${AIR} == "I" && ${yn} == "N" ]];
					read -p "Enter the rule's position: " rp
                                        iptables -I ${chain} ${rp} -s ${ip} -j ${tr}
					break
				else
					sleep 2
					continue
				fi
			done	
			;;
		6)
			;;
		7)
			read -p "Enter the name of the chain you want to create: " ccchain
			iptables -N ${ccchain}
			;;
		8)
			read -p "Enter the name of the custom chain you want to delete: " dcchain
			iptables -X ${dcchain}
			;;	

		*)
			echo "please enter only one of the 8 options above!"
	esac

else
	echo "\nRoot user not detected!"
	exit 1
fi
