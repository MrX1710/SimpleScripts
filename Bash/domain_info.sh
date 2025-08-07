#!/usr/bin/env bash

TARGET=${1}
ARGS=${#}
STATUS=${?}

if [[ -z "${TARGET}" ]];
then
	echo "the Target should be provided"
	echo "e.g: tool exemple.com"
	exit 1
fi
if [[ "${ARGS}" -gt 1 ]];
then
	echo "Only one argument should be provided"
	exit 1
fi

if ! [[ "${TARGET}" =~ ^[a-zA-Z0-9]+\.([a-zA-Z0-9]{2,})$ || "${TARGET}" =~ ^[a-zA-Z0-9]+\.([a-zA-Z0-9]{2,})+\.([a-zA-Z0-9]{2,})$ ]];
then
	echo "Enter a valid domain name"
	exit 1
fi
#exp of the regexp:
#^[a-zA-Z0-9] >> matches any alphanumeric value that begins with known caracters or numbers from a to z cap or not, from 0 to 9, or just simple matches the local part of the DN
#+\. >> matches a dot (after the alphanumeric value there will be a dot)
#([a-zA-Z0-9]{2,} >> matches any Top Level Domain .com .net .gov ect.. with 2 chars at least
#the second condition is the same as one just add a second TLD e.g: exemple.com.uk

#IP OF TARGET
echo -e "\e[1;31m[IP]:\e[0m"
dig "${TARGET}" +short

#IPv6 OF TARGET
echo -e "\n\e[1;31m[IPv6]:\e[0m"
dig "${TARGET}" AAAA | grep AAAA | sed '1,2d'

#MAIL EXCHANGE RECORDS
echo -e "\n\e[1;31m[MX Records]:\e[0m"
dig "${TARGET}" MX | grep MX | sed '1,2d'

#SERVER NAMES
echo -e "\n\e[1;31m[Server Names]:\e[0m"
whois "${TARGET}" | grep Name\ Server | awk -F\: '{print $2}'

#NMAP SCAN
echo -e "\n\e[1;31m[PORT SCANNING]:\e[0m"
nmap -Pn "${TARGET}" | grep open
