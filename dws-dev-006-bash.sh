#!/bin/bash

#for commands more than one word
#4 is forth and last argument before commands
num=$(( $# - 4 ))
command="${@: -$num}"

#check flags and inputs
while getopts i:n: flag
do
    case "${flag}" in
        i) interval=${OPTARG};;
        n) number=${OPTARG};;
    esac
done

#run command
n=0
$command
if [ $? -eq 0 ]; then
	exit 0
else
	while [ "$n" -lt "$number" ]
	do
		$command
		if [ $? -eq
		n=$(( $n + 1 ))
	done
fi

#message if successfull
if [ ! $done ]; then
	echo "Program Failed" >&2
	exit 1
fi




