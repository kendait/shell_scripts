#!/bin/bash

httpdReport() {
	httpdStatus=$(curl -sI http://localhost:80 | grep '^HTTP' | sed 's/[[:space:]]*$//')
	if [[ $httpdStatus == 'HTTP/1.1 200 OK' ]]; then
		echo "Apache: Running"
	elif [[ $httpdStatus == "" ]]; then
		echo "Apache: Offline"
	else
		echo "Apache: ERROR"
	fi
}

mysqlReport() {
	mysqlStatus=$(ps aux | grep mysql | awk '{print $1}' | grep 'mysql' | grep -v 'grep' | uniq)
	if [[ $mysqlStatus == "_mysql" ]]; then
		echo "MySQL: Running"
	elif [[ $mysqlStatus == "" ]]; then
		echo "MySQL: Offline"
	else
		echo "MySQL: ERROR"
	fi
}

firewallReport() {
	firewallStatus=$(system_profiler SPFirewallDataType | grep '^[[:space:]]*Mode' | sed 's/[[:space:]]*$//' | sed 's/^[[:space:]]*//') 
	if [[ $firewallStatus == "Mode: Limit incoming connections to specific services and applications" ]]; then
		echo "Firewall: On"
	elif [[ $firewallStatus == "Mode: Block all incoming connections" ]]; then
		echo "Firewall: On"
	elif [[ $firewallStatus == "Mode: Allow all incoming connections" ]]; then
		echo "Firewall: Offline"
	fi
}

serverReport() {
	httpdReport
	mysqlReport
	firewallReport
}

if [[ $# -eq 0 ]]; then
	serverReport
else
	case $1 in

		online|start)
			httpdCurrentStatus=$(httpdReport)
			if [[ $httpdCurrentStatus == 'Apache: Offline' ]]; then
				#echo "turn on apache"
				sudo apachectl configtest &> /dev/null && sudo apachectl start &> /dev/null \
					&& echo "Apache: SUCCESSFULLY STARTED"
			fi
			mysqlCurrentStatus=$(mysqlReport)
			if [[ $mysqlCurrentStatus == 'MySQL: Offline' ]]; then
				#echo "turn on mySQL"
				sudo /usr/local/mysql/support-files/mysql.server start &> /dev/null \
					&& echo "MySQL: SUCCESSFULLY STARTED"
			fi
			;;

		offline|stop)

			httpdCurrentStatus=$(httpdReport)
			if [[ $httpdCurrentStatus == 'Apache: Running' ]]; then
				#echo "turn on apache"
				sudo apachectl stop &> /dev/null \
					&& echo "Apache: SUCCESSFULLY STOPPED"
			fi

			mysqlCurrentStatus=$(mysqlReport)
			if [[ $mysqlCurrentStatus == 'MySQL: Running' ]]; then
				#echo "turn on mySQL"
				sudo /usr/local/mysql/support-files/mysql.server stop &> /dev/null \
					&& echo "MySQL: SUCCESSFULLY STOPPED"
			fi
			;;

	esac
fi
