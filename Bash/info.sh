#!/bin/bash

package_name=${1}

nala show ${package_name} 2> /dev/null

if [[ -z ${package_name} ]];
then
        echo "Invalid entry!"
        exit 1
fi

if ! command -v nala &> /dev/null;
then
        echo "nala repository not found."
        echo "Switching to apt."
        sleep 1
        apt info ${package_name} 2> /dev/null
        exit 0
fi