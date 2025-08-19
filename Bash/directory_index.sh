#!/bin/bash
#
FILE=${1}
OUTPUT_FOLDER=${2}

if [[ ! -s "${FILE}" ]];
then
	echo "You must provide a non empty file"
	exit 1
fi

if [[ -z "${OUTPUT_FOLDER}" ]];
then
	OUTPUT_FOLDER="RESULTS"
fi

while read -r line;
do
	URL=$(echo "${line}" | xargs)
	if [[ -n ${URL} ]];
	then
		echo "Testing ${URL} for directory indexing..."
		if curl -L -s "${URL}" | grep -q -e "Index of /" -e "[PARENTDIR]";
		then
			echo -e "\t -!- Found Directory Indexing page at ${URL}"
			echo -e "\t -!- Results Downloaded at ${OUTPUT_FOLDER}"
			mkdir -p "${OUTPUT_FOLDER}"
			wget -q -r -np -R "index.html*" "${URL}" -P ${OUTPUT_FOLDER}
		fi
	fi
done < <(cat "${FILE}")
