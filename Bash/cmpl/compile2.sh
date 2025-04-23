#!/usr/bin/env bash

FILE=${1}
if [[ -z "${FILE}" ]];
then
        echo "Invalid Input"
        exit 1
fi
if ! [[ "${FILE}" == *.c ]] || [[ "${FILE}" == *.cpp ]]; # or ++ instead of pp
then
	echo "file.c or .cpp(++) only"
        exit 1
else
	gcc "${FILE}" -o "${FILE%.*}"
	exit 0
fi
