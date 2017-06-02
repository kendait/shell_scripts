#!/usr/local/bin/bash
#Name: listBashRCaliasNames.sh
#Author: Kenneth Dait
#Description: list alias names in ~/.bashrc
#Created: Fri May 26 16:19:10 2017

grabOnlyAliasNames() {
	aliasArr=($(cat ~/.bashrc.d/aliases.bash \
		| grep '^[[:space:]]*alias.*$' \
		| sed 's/^[[:space:]]*alias[[:space:]]//g' \
		| sed 's/=.*$//' \
		| tr '\n' ' '))
	echo -en "\n"
	echo "BASHRC ALIASES (in ~/.bashrc.d/aliases.bash)" \
	echo "ALIAS COUNT: ${#aliasArr[@]}"
	echo -en "\n"
	for i in ${aliasArr[@]}; do
		echo -en "$i\t"
	done
	echo -en "\n\n\n"
}

justGrabAliases() {
	cat ~/.bashrc.d/aliases.bash \
		| grep '^[[:space:]]*alias.*$'
}
grabOnlyAliasNames
#justGrabAliases
