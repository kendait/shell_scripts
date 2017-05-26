#!/usr/local/bin/bash
#Name: getLatestSoftwareVersions.sh
#Description: Gets the latest version numbers for software I'd like to stay on top of.
#Created: Fri May 26 11:35:44 2017

##FUNCTIONS

getLocalSystemVersions() {
	localApache=$(httpd -v | head -n 1 | awk -F ":" '{print $NF}')
	localApache=$(echo $localApache | sed 's/^[[:space:]]*//')
	declare -r localApache

	localPHP=$(php -v | head -n 1 | sed 's/[[:space:]]*(built:.*$//g')
	localHomeBrew=$(brew -v | head -n 1)
}


##BEGIN

getLocalSystemVersions

echo -en "\n"

echo "APACHE"
echo "local: ${localApache}"
which apachectl httpd

echo -en "\n"

echo "PHP"
echo "local: ${localPHP}"

echo -en "\n"
echo "Homebrew"
echo "local: ${localHomeBrew}"

echo -en "\n"
##END
