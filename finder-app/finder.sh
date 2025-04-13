#!/bin/bash

filesdir=$1
searchstr=$2

if (( "$#" != 2 )); then
	echo "Argument count does not match 2"
	exit 1
fi

if [ ! -d "$filesdir" ]; then
	echo "Could not file the directory on the file system."
	exit 1
fi


match_files=$(grep -R "$filesdir" -e "$searchstr" -c | sed s/".*\:0"/""/g | awk 'NF' | wc -l)
match_lines=$(grep -R "$filesdir" -e "$searchstr" -c | sed s/".*\:0"/""/g | awk 'NF' | sed s/".*:"/""/g | paste -sd+ | bc)

echo "The number of files are $match_files and the number of matching lines are $match_lines"


