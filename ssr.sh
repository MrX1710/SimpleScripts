#!/bin/bash

PACKAGE=$1

if [[ -z ${PACKAGE} ]];
then
        echo "Invalid entry"
        exit 1
else
        sudo snap remove ${PACKAGE}
fi
