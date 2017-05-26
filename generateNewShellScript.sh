#!/usr/local/bin/bash

#	this script initializes a new shell script

##VARS
#authorName=$USER
authorName="Kenneth Dait"
dateStr=$(date +%Y%m%d_%H%M%S)	#used for default name
creationDateString=$(date +%c)		#used for metadata in the hader of the new script
defaultScriptName="${dateStr}.sh"		#the unique default script name
defaultScriptDesc="I'm lazy about labelling my things." #the default description. you may want to change this
scriptName=""	#will either be set to default, or to user's input
scriptDesc="" 	#will either be set to default or user's input
defaultPath="/Users/kenpd/Developer/shell_scripts"	#this will do for now
fullScriptPath=""	#will be set

##FUNCTIONS
testing() {
	typeset -r targetDir="testing"
	typeset scriptName
	typeset -u scriptDesc
	echo $targetDir
	typeset +r targetDir
	targetDir="killed it"
	echo $targetDir
	echo "done"

	echo $TMPFILE
	echo "testing" > $TMPFILE
	less $TMPFILE
}

manageTempFile() {
	tempFile=`basename $0`
	TMPFILE=`mktemp -q /tmp/${tempFile}.XXXXXX`
	if [ $? -ne 0 ]; then
	       echo "$0: Can't create temp file, exiting..."
	       exit 1
	fi
	trap "[[ -f $TMPFILE ]] && rm $TMPFILE" INT
	trap "[[ -f $TMPFILE ]] && rm $TMPFILE" QUIT
}

setScriptFileParameters() {
	handleReturnToMainScript() {
		reportErr() {
			echo "ERROR: setting script parameters produced an error."
			echo "Exiting..."
			exit 1
		}
		[[ ! -z $scriptName ]] \
			&& [[ ${scriptName: -3} == ".sh" ]] \
			&& [[ ! -z $scriptDesc ]] \
			&& [[ ! -z $defaultPath ]] \
			&& [[ ! -z $fullScriptPath ]] \
			&& return \
			|| reportErr
	}
	checkAndSetDefaults() {
		[[ -z $scriptName ]] && scriptName=$defaultScriptName
		[[ -z $scriptDesc ]] && scriptDesc=$defaultScriptDesc
	}
	echo "GENERATE NEW SHELL SCRIPT:"
	read -p "Name? (${defaultScriptName}): " scriptName
	read -p "Description? (placeholder will be used): " scriptDesc
	checkAndSetDefaults
	if [[ ${scriptName: -3} != ".sh" ]]; then
		scriptName=$scriptName".sh"
	fi
	fullScriptPath="${defaultPath}/${scriptName}"
	handleReturnToMainScript
}

verifyCreationOfFile() {
	unset reportErr
	reportErr() {
		echo "ERROR: User (${USER}) is not the owner of target directory (${defaultPath})"
		echo "Exiting..."
		exit 1
	}
	pathOwner=$(stat -f '%Su' $defaultPath)
	if [[ $pathOwner != $USER ]]; then
		reportErr
	fi
	if [[ ! -z "$(ls $fullScriptPath 2>/dev/null)" ]]; then
		#file name at $defaultPath already exists
		#prompt for new name
		read -p "Enter a new name: " scriptName
		if [ -z $scriptName ]; then
			scriptName=$defaultScriptName
			fullScriptPath="${defaultPath}/${scriptName}" ####

			if [[ ! -z "$(ls $fullScriptPath 2>/dev/null)" ]]; then
				reportErr
			fi
		fi
	else
		#ready to proceed
		return
	fi
}

testCommandExitStatus() {
	#must pass "$?" as $1
	capturedStatus=$1
	if [ -z $capturedStatus ]; then
		echo "ERROR: there was a problem with error tolerance."
		echo "Exiting..."
		exit 1
	elif [[ $capturedStatus -gt 0 ]]; then
		echo "ERROR: there was a problem with \"$2\"."
		echo "Exiting..."
		exit 1
	elif [[ $capturedStatus == 0 ]]; then
		return
	fi
}

fillScriptContents() {
	unset reportErr
	reportErr() {
		echo "ERROR: There was an error in setting the new script's contents"
		echo "Exiting..."
		exit 1
	}
	successfulCreation=""
	getUsersShell=$SHELL
	[[ ! -z getUsersShell ]] && \
		(echo -en '#!' >> $TMPFILE && \
		echo "${getUsersShell}" >> $TMPFILE && \
		echo "#Name: ${scriptName}" >> $TMPFILE && \
		echo "#Author: ${authorName}" >> $TMPFILE && \
		echo "#Description: ${scriptDesc}" >> $TMPFILE && \
		echo "#Created: ${creationDateString}" >> $TMPFILE && \
		cat $TMPFILE >> $fullScriptPath) && \
		successfulCreation="true" \
		|| reportErr

	if [[ $successfulCreation == "true" ]]; then
		return
	else
		reportErr
	fi
}

cleanUp() {
	rm $TMPFILE
}

#no args for now, will add later
#script will prompt user for needed info
#	and set default values if needed
setScriptFileParameters
#these should now be set
#echo $scriptName && echo $scriptDesc
verifyCreationOfFile
touch $fullScriptPath; testCommandExitStatus $? "the touch command"
chmod +x $fullScriptPath; testCommandExitStatus $? "making the script executable"
[[ -x $fullScriptPath ]] && echo \
	|| (echo -en "ERROR: There was an error just after script file creation.\nExiting..." && exit 1)
manageTempFile
[[ -f $TMPFILE ]] && fillScriptContents

cleanUp
echo "Script successfully created:"
echo $fullScriptPath
echo $fullScriptPath | pbcopy
echo "Script path copied to clipboard!"
exit 0
