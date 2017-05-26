#!/usr/local/bin/bash
#Name: syspro.sh
#Description: Aims to simplify the system_profiler command
#Created: Fri May 26 09:27:43 2017

##VARS


##FUNCTIONS
printDataList() {
	echo -en "\n\tSYSTEM PROFILER OPTIONS:\n\n"
	#echo ${rawDataTypes[@]} | xargs -n 3 -I {} printf "{}\n" | \
		#awk '{printf (" %-30s\t%-30s\t%-30s\n",$1,$2,$3)}'
	echo ${formattedDataTypes[@]} | xargs -n 3 -I {} printf "{}\n" | \
		awk '{printf (" %-18s\t%-18s\t%-18s\n",$1,$2,$3)}'
	echo -en "\n\n"
	exit 1
}



##BEGIN

#1. gather available "datatypes" ($ system_profiler -listdatatypes)
rawDataTypes=($(system_profiler -listdatatypes|grep '^SP'|tr '\n' ' '))
formattedDataTypes=($(system_profiler -listdatatypes|grep ^SP|sed 's/^SP//g'|sed 's/DataType$//'|tr '\n' ' '))

if [ -z $1 ]; then
	printDataList
else
	targetDataType="SP"$1"DataType"
	#echo $targetDataType && exit
	system_profiler $targetDataType
fi
##END
