#!/bin/bash
writefile=$1
writestr=$2
if (( "$#" != 2 )); then
	echo "Number of arguments does not match 2"
	exit 1
fi

if [ ! -d "$(dirname "$writefile")" ]; then
	mkdir -p "$(dirname "$writefile")"
fi

echo "$writestr" > $writefile 2> /dev/null
if (( $? != 0 )); then
	echo "writefile: $writefile could not be written to"
	exit 1
fi

