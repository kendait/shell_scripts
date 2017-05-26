#!/usr/local/bin/bash
#Name: listMFBinScripts.sh
#Description: list linked scripts in $MF/bin
#Created: Fri May 26 10:35:16 2017

echo -en "\n\tMF SCRIPTS (\$MF/bin)\n\n"
ls -oGFL $MAINFRAME_PATH/bin
#find "$MAINFRAME_PATH/bin"
echo -en "\n\n"
exit 0
