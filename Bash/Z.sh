#!/bin/bash
ZK="\e[1;31mZOMBIE KILLER\e[0m"
echo -e "                         |"${ZK}"|"
echo ""
echo "To stop the script if there's no ZP to kill enter: n or stop."
echo "To start the script if there's a ZP to kill enter: y or start."
echo -e "\n"


invalid_input() {
	echo -e "\e[1;31mInvalid input! \e[0m"
	exit 1
}

KEYB_INT() {
	echo -e "\n\e[1mKeyboard Interruption\e[0m"
	exit 130
}
trap KEYB_INT SIGINT
echo "<user>     <PID>   <PPID>"
ps -ef | grep defunct
echo -e "\n"
read -p "Enter Your choice > " Z

case "${Z,,}" in
	n|stop)
		exit 0
		;;
	y|start)
		read -p "Enter the parent process ID > " ppid
		if [[ -z "${ppid}" ]];
		then
			invalid_input
		else
			kill "$ppid"
			ps -ef | grep defunct
		fi
		;;
	*)
		invalid_input
esac
