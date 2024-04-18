#!/bin/bash
ZK="\e[1;31mZOMBIE KILLER \e[0m"
a="|"
b="|"
echo    "                        ----------------------------                "
echo -e "                       $a       $ZK       $b                  "
echo    "                        ----------------------------                "
echo ""
echo ""
echo "To stop the script process if there's no ZP to kill enter: s or Stop."
echo "To start the script process if there's a ZP to kill enter: y or Start."
echo ""


invalid_input() {
	echo -e "\e[1;31mInvalid input! \e[0m"
	exit 1
}
sig_int() {
	echo -e "\n\e[1mProgram exited with SIGINT \e[0m"
	exit 0
}
trap sig_int SIGINT
ps aux | egrep "Z |Defunct"
echo ""
read Z
if [ -z $Z ];
then
    invalid_input
fi
if [[ $Z ==  "s" || $Z == "Stop" ]];           # in case there's no child process to kill, the script stops
then
         echo -e  "\e[1mProcess stopped \e[0m"

elif [[ $Z == "y" || $Z == "Start" ]];           # in case there's a child process to kill, the lines down
then                                           # will be executed after the user entered the PID (Process Identifier)
         read -p "Enter the ZP ID: " zpid
	 if [ -z $zpid ];
         then
		 invalid_input
         else
		 ps -o ppid== -p $zpid
         fi

         read -p "Enter the PPID to kill it: " ppid  #PPID Stands for Parent Process Identifier
	 if [ -z $ppid ];
         then
              invalid_input
         else
              ps -e | grep $ppid
              kill -SIGKILL $ppid
	 fi

else
         echo -e "\e[1mCommand not found! \e[0m"
                                                #If the user input is neither (s, Stop) nor (y, Yes), this line will be shown to the user
fi
