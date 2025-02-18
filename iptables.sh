#!/bin/bash
#A simple script that will manage filter table of iptables

##VARIABLES
ID=${UID}
STATUS=${?}
USR=$(getent passwd 1000 | cut -d: -f6)
FLAG_FILE=${USR}/Desktop/flag_file.txt
##

##COLOR,BOLD
RED='\033[31m'
GREEN='\033[32m'
BOLD='\033[1m'
NC='\033[0m'

keyboard_interruption() {
	echo -e "\n${BOLD}${GREEN}Keyboard Interruption${NC}"
	exit 0
}
trap keyboard_interruption SIGINT

#I'm gonna set up a list of rules that i think are necessary
#then i'm gonna set INPUT policy as DROP
#i'm gonna comment the function in the code so if you want to set
#theses rules just uncomment it, it'll run only one time.

default_rules() {

	if [[ ! -f "${FLAG_FILE}" ]];
	then
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
		touch ${FLAG_FILE}
		echo "This is the flag file from iptables script, don't remove it" >> ${FLAG_FILE}
		iptables -P INPUT DROP
	fi
}

CHECK() {
	if [[ ${ID} != 0 ]];
	then
		echo -e "${BOLD}${RED}You are not allowed to run this script${NC}"
		exit 1
	fi
}

APPEND_INSERT() {
	read -p "Do you want to append or insert a rule?[A/I]: " AI
}

CHECK

cat << EOF
  ( Enter "c" or "C" to clear the screen and print the menue again )
  ( Enter "s" or "S" to stop the script or you can use CTRL+C      )
  1) List iptables rules
  2) Flush iptables rules
  3) Delete iptables rules
  4) Append/Insert rules using port and dport (-p --dport)
  5) Append/Insert rules using source and destination source (-s -d)
  6) Append/Insert rules using source, d with port and dport
  7) Append/Insert rules for incoming traffic on specefic interfacs
  8) Append/Insert rules for outgoing traffic on specefic interfaces
  9) Create a custom chain
  10) Rename a custom chain
  11) Delete a custom chain
  12) Set policy for a chain
EOF

if [[ ${ID} == 0 ]];
then
    default_rules
    while true; do
	    read -p  "$(echo -e "${BOLD}${GREEN}Make your choice: ${NC}")" choice
		case "${choice}" in
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
				iptables -D "${chain^^}" "${rn}" 2>/dev/null
				;;
			4)
				APPEND_INSERT
				read -p "Enter the chain name: " chain
				read -p "Enter the port name: " port
				read -p "Enter the destination port number: " dport
				read -p "Enter the target rule: " tr
				if [[ "${AI^^}" == "A" ]];
				then
					iptables -A "${chain^^}" -p "${port,,}" --dport "${dport}" -j "${tr^^}" 2>&1
				elif [[ "${AI^^}" == "I" ]];
				then
					read -p "Enter the rule's position: " rp
					iptables -I "${chain^^}" "${rp}" -p "${port,,}" --dport "${dport}" -j "${tr^^}" 2>&1
				else
					exit 1
				fi
				;;
			5 | 6)
				INPUT_ASK() {
					read -p "Do you want to add a destination?[Y/N]: " yn
					read -p "Enter the chain's name: " chain
					read -p "Enter the ip source: " ip
					read -p "Enter the target rule: " tr
				}
				MAIN() {
					local port="$4"
			        	local dport="$6"

					if [[ "${AI^^}" == "A" ]];
					then
						cmd="iptables  -A "${chain^^}" -s "${ip}" -p "${port}" -d "${d}" --dport "${dport}" -j "${tr^^}" 2>&1"
					elif [[ "${AI^^}" == "I" ]];
					then
						read -p "Enter the rule's position: " rp
						cmd="iptables  -I "${chain^^}" "${rp}" -s "${ip}" -p "${port}" -d "${d}" --dport "${dport}" -j "${tr^^}" 2>&1"
					else
						exit 1
					fi
				   	[[ -z "$port" ]] && cmd="${cmd//-p /}"  # Remove -p if port is empty
					[[ -z "$dport" ]] && cmd="${cmd//--dport /}"  # Remove --dport if dport is empty
					[[ -z "$d" ]] && cmd="${cmd//-d /}"  # Remove -d if destination is empty 
					eval "$cmd" 2>&1

				}
				if (( "${choice}" == 5 ));
				then
					APPEND_INSERT
					INPUT_ASK

                                        #APPEND
					if [[ "${AI^^}" == "A" && "${yn^^}" == "Y" ]];
					then
						read -p "Enter the destination source: " d
						MAIN "${chain}"  "" "${ip}"  ""  "${d}"  ""  ""  "${tr^^}"
					elif [[ "${AI^^}" == "A" && "${yn^^}" == "N" ]];
					then
						MAIN "${chain}" "" "${ip}" "" "" "" "${tr^^}"

					#INSERT
					elif [[ "${AI^^}" == "I" && "${yn^^}" == "Y" ]];
					then
						read -p "Enter the destination source: " d
						MAIN "${chain}" "${rp}" "${ip}" "" "${d}" "" "${tr^^}"
					elif [[ "${AI^^}" == "I" && "${yn^^}" == "N" ]];
					then
						MAIN "${chain}" "${rp}" "${ip}" "" "" "" "${tr^^}"
					fi
				fi

				if (( "${choice}" == 6 ));
				then
					APPEND_INSERT
					INPUT_ASK

					#APPEND
					read -p "Enter the port name: " port
					read -p "Enter the destination port: " dport

					if [[ "${AI^^}" == "A" && "${yn^^}" == "Y" ]];
					then
						read -p "Enter the destination source: " d
						MAIN "${chain}" "" "${ip}" "${port}" "${d}" "${dport}" "${tr^^}"
					elif [[ "${AI^^}" == "A" && "${yn^^}" == "N" ]];
					then
						MAIN  "${chain}" "" "${ip}" "${port}" "" "${dport}" "${tr^^}"

                                        #INSERT
					elif [[ "${AI^^}" == "I" && "${yn^^}" == "Y" ]];
					then
						read -p "Enter the destination sosurce: " d
						MAIN "${chain}" "${rp}" "${ip}" "${port}" "${d}" "${dport}" "${tr^^}"
					elif [[ "${AI^^}" == "I" && "${yn^^}" == "N" ]];
					then
						MAIN "${chain}" "${rp}" "${ip}" "${port}" "" "${dport}" "${tr^^}"
					fi
				fi
				;;
			7 | 8)
				INPUT_ASK() {
			        read -p "Enter the interface's name: " interface
			        read -p "Enter the target rule: " tr
				}
				MAIN() {

					local chain="$1"
					local INC_OUTG="$2"

					APPEND_INSERT
					INPUT_ASK

					if [[ "${AI^^}" == "A" ]];
					then
						iptables -A "${chain}" -"${INC_OUTG}" "${interface}" -j "${tr^^}"
					elif [[ "${AI^^}" == "I" ]];
					then
						read -p "Enter the rule's position: " rp
						iptables -I "${chain}" "${rp}" -"${INC_OUTG}" "${interface}" -j "${tr^^}"
					fi

				}
				if (( "${choice}" == 7 ));
				then
					MAIN "INPUT" "i"
				fi
				if (( "${choice}" == 8 ));
				then
					MAIN "OUTPUT" "o"
				fi
				;;

			9)
				read -p "Enter the custom chain's name: " cchain
				iptables -N "${cchain^^}" 2>&1
				;;
				10)
				read -p "Enter the old chain's name: " ochain
				read -p "Enter the new chain's name: " nchain
				iptables --rename-chain "${ochain^^}" "${nchain^^}" 2>&1
				;;
				11)
				read -p "Enter the custom chain's name you want to delete: " dcchain
				iptales -X "${dcchain^^}" 2>&1
				;;
			12)
				read -p "Enter the chain's name: " chain
				read -p "Enter the desired chain's policy: " policy
				iptables -P "${chain^^}" "${policy^^}" 2>&1
				;;
			c | C)
				#JUST ANOTHER WAY TO MAKE IT
				#menue=""
				#export menue
				#./menue.sh
				## Make a menue.sh file, copy the script menue to it 
				## then call the variable declared above, like this $menue
				## now you can call this file by just taping ./menue.sh in this script
				clear
				./iptables.sh
				;;
			s |S)
				echo -e "${BOLD}${GREEN}Script Stoped${NC}"
				exit 1
				;;
			*)
				echo -e "${BOLD}${RED}Option not available${NC}"
				continue
		esac
	done
fi
