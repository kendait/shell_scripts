#!/usr/local/bin/bash

probeScriptInfo() {
	invocationPath=$0
	echo "TEMP FILE: "$tmpFile
	echo "Script invoked with: "$invocationPath
	if [[ ${0:0:1} == "." ]]; then
		invocationPath=$(echo $invocationPath | sed "s|^\.|${PWD}|")
	fi
	echo "Full absolute path: "$invocationPath
	echo "PWD: "$PWD
	echo "basename: "$(basename $0)
}

dateStr=$(date +%Y%m%d%H%M%S.tmp)
tmpFile=/tmp/${dateStr}_$$.log
#trap (echo "sorry, can't let you exit") INT

probeScriptInfo
