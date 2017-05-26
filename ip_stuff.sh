#!/usr/local/bin/bash
#Name: ip_stuff.sh
#Description: Pulls down internet connection data
#Created: Fri May 26 09:20:40 2017
#
#	the website i'm using is here:
#	https://ifcfg.me

##VARS


##FUNCTIONS
confirmAirPortStatus() {
	airportStatus=$(system_profiler SPAirPortDataType | grep -v "^[[:space:]]*$" | head -n 23 | tail -n 1 | awk '{print $NF}')
	if [[ $airportStatus == "Off" ]]; then
		echo "ERROR: Wi-Fi is turned off."
		echo "Exiting..." 
		exit 1
	elif [[ $airportStatus == "Connected" ]]; then
		return
	else
		echo "ERROR: There was an issue accessing Wi-Fi status."
		echo "AirPort reported: ${airportStatus}."
		echo "Exiting..."
		exit 1
	fi
}


##BEGIN
confirmAirPortStatus 
echo "AirPort Status: "$airportStatus

if [ -z $1 ]; then
	case $1 in
		home)
			open "https://ifcfg.me";;
		*)
			echo "${1} is not a recognized command."
			exit 1;;
	esac
fi

exit 0

##END
