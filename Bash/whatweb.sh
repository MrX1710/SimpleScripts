#!/bin/bash
#
IP="${1}"
VALID_IP_FORMAT="^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$"

if [[ -z ${IP} ]];
then
	echo "You must enter an IP_addr"
	exit 1
fi

if [[ "${#}" -gt 1 ]];
then
	echo "Only one argument allowed (IP_addr)"
	exit 1
fi

if [[ ! ${IP} =~ ${VALID_IP_FORMAT} ]];
then
	echo "Enter a valid IP_add format"
	exit 1
fi

result=$(whatweb ${IP} --log-json=/dev/stdout --quiet | jq)

if [[ -n ${result} ]];
then
	echo -e "IP --> ${IP}\n${result}" >> ${IP}.json
	sleep 1
	echo "Results successfully saved in ${IP}.json"
else
	exit 1
fi
