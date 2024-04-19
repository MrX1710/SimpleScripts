#!/bin/bash
#Test using getopts with ping, dig and whois (connexion required to work)
invalid_input() {
	echo "./pdw.sh: invalid option --'$OPTARG'"
	echo "try ./pdw.sh -h help for more help"
}
help() {
	echo "To start a ping: ./pdw.sh -p [Domaine_Name] or [Domain_IP]"
        echo "To start a dig : ./pdw.sh -d [Domain_Name]  or [Domain_IP]"
        echo "To start a whois search: ./pdw.sh -w [Domaine_Name] or [Domain_IP]"
}
while getopts ":p:d:w:h:" opt;
do
	case $opt in
		h)
			input=$OPTARG
			if [ $input == "help" ];
			then
				help $input
			else
				invalid_input
				exit 1
			fi
			exit 0
			;;
		p)
			input=$OPTARG
			ping $input
			;;
		d)
			input=$OPTARG
			dig $input
			;;
		w)
			input=$OPTARG
			whois $input
			;;
		\?)
			invalid_input
			exit 1
			;;
		:)
			echo "Arguments required!" >&2
			invalid_input
			exit 1
	esac
done
if [ -z "$input" ];
then
	echo "Invalid input!" >&2
	invalid_input
	exit 1
fi
