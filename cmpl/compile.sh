#!/usr/bin/env bash

FILE=${1}

if [[ -z "${FILE}" ]];
then
	echo "Invalid Input"
	exit 1
fi
if [[ "${FILE}" == *.c ]] || [[ "${FILE}" == *.cpp ]]; # or ++ instead of pp
then
	echo "Enter the file name only, without it's extension"
	exit 1
else
	gcc "${FILE}.c" -o "${FILE}" 2>/dev/null
	exit 0
fi

