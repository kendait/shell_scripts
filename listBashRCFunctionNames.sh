#!/usr/local/bin/bash
#Name: listBashRCFunctionNames.sh
#Author: Kenneth Dait
#Description: lists named functions in ~/.bashrc
#Created: Fri May 26 16:15:00 2017



functionsWithLineNums() {
	echo "BASHRC FUNCTIONS (in ~/.bashrc.d/functions.bash)" \
		&& cat ~/.bashrc.d/functions.bash \
		| nl | sed "s|()[[:space:]]*{|()|g" \
		| grep '^[[:space:]0-9]*[a-zA-Z][a-zA-Z0-9]*()' \
		| sed 's/^[[:space:]]*//' \
		| awk '{printf ("%-25s\t(line# %-4s)\n",$2,$1)}' \
		| sed 's/[[:space:]]*)$/)/' \
		| grep '^[A-z0-9]*()'
}

functionsWithLineNums


# justGrabTheFunctions() {
# 	cat "/Users/kenpd/.bashrc.d/functions.bash" | \
# 		sed "s|()[[:space:]]*{|()|g"| \
# 		grep '^[a-zA-Z][a-zA-Z0-9]*\(\)'
# }
#justGrabTheFunctions
