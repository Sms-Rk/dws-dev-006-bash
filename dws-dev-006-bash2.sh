#!/bin/bash

interval_def=5
number_def=12
command_def=NULL
if [ $# -eq 0 ]; then
	if [[ -v $COMMAND ]]; then
		echo "Invalid"
		exit 1
	else 	
		interval="${INTERVAL:-$interval_def}"
		number="${NUMBER:-$number_def}"
		command="${COMMAND}"
	fi
fi

nu=0
num_arg=$#
while getopts i:n: flag
do
    if [[ "${flag}" == "i" ]]; then
		interval=${OPTARG}
		nu=$(( $nu + 2 ))
		i=1
	elif [[ $i -ne 1 ]]; then
		interval="${INTERVAL:-$interval_def}"
	fi
	if [[ "${flag}" == "n" ]]; then
		number=${OPTARG}
		nu=$(( $nu + 2 ))
		n=1
	elif [[ n -ne 1 ]]; then
		number="${NUMBER:-$number_def}"
	fi
done




if [[ $# -ne 0 ]]; then

	if [[ nu -eq 4 && num_arg -gt 4 ]]; then
		num=$(( $# - 4 ))
		command="${@: -$num}"
	elif [[ ! -z "$COMMAND" ]] && [[ nu -eq 4 && num_arg -eq 4 ]] || [[ nu -eq 2 && num_arg -eq 2 ]]; then
		command="${COMMAND}"
	elif [[ nu -eq 2 && num_arg -gt 2 ]]; then
		num=$(( $# - 2 ))
		command="${@: -$num}"
	elif [[ nu -eq 0 && num_arg -gt 0 ]]; then
		command=$@
		interval="${INTERVAL:-$interval_def}"
		number="${NUMBER:-$number_def}"
	else
		echo "Invalid Command"
		exit 1
	fi	
fi

echo $number$interval$command



#run command
n=0
$command


if [ $? -eq 0 ]; then
	exit 0
else
	while [[ $n -lt $number ]]
	do
		$command
		if [ $? -eq 0 ]; then
			done=TRUE
			exit 0
		fi
		sleep $interval
		n=$(( $n + 1 ))
	done
fi

#message if successfull
if [ ! $done ]; then
	echo "Unsuccessfull"
	exit 1
fi
