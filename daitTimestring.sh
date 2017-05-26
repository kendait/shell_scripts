#!/usr/local/bin/bash
#Name: daitTimestring.sh
#Description: Controls some time formatting for quick use
#

dait() {

	usage() {
		echo -e "usage: \t dait [-d --date | -dn --datenumbers | -ds --datesortable]"
		echo -e "	\t dait [-t --time | -ts --timestring | -dtstr|--datetimestring]"
		echo -e "	\t dait [-fs --fullstring | -u --usage | -h --help]"

	}

	if [[ $# -eq 0 ]];
	then
		echo $(date +"%Y%m%d_%H%M_%S")

	else
		for i in "$@"; do
			returnString=""
			case $i in
				-d|--date) 			returnString=$(date +"%h %d, %Y");;
				-dn|--datenumbers)		returnString=$(date +"%m-%d-%y");;
				-ds|--datesortable)		returnString=$(date +"%Y%m%d");;
				-t|--time) 			returnString=$(date +"%H:%M:%S");;
				-ts|--timestring) 		returnString=$(date +%H%M%S);;
				-dtstr|--datetimestring)	returnString=$(date +%Y%m%d%H%M%S);;
				-u|--usage)			usage;;
				-h|--help)			usage;;
				-fs|--fullstring)		returnString=$(date +$Y%m%d%H%M%S);;
				*)				echo "[dait]: "$1" is not a recognized argument." && return;;
			esac
		done
	fi

	if [ -z "$returnString" ]; then return; fi

	echo $returnString

}
