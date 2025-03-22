#!/bin/bash
PACKAGE=$1

snap info ${PACKAGE} 2>/dev/null

if [[ -z ${PACKAGE} ]];
then
	echo "Invalid entry!"
	exit 1
fi

