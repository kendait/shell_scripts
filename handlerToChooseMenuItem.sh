#!/usr/local/bin/bash
#Name: handlerToChooseMenuItem.sh
#Author: Kenneth Dait
#Description: can be used to choose a menu item
#Created: Wed May 31 05:26:58 2017

#the following script found on developer.apple.com here:
#https://developer.apple.com/library/content/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/AutomatetheUserInterface.html

usage() {
    echo "usage"
    exit 1
}

#echo "args("$#"): ${@}"

if [[ $# -ne 3 ]]; then 
    usage
fi

echo "3 args detected"

theAppName="${1}"
theMenuName="${2}"
theMenuItemName="${3}"

osascript <<-EOF
try
-- Bring the target app to the front
tell application $theAppName
activate
end tell
-- Target the app
tell application "System Events"
tell process $theAppName
-- Target the menu bar
tell menu bar 1
-- Target the menu by name
tell menu bar item theMenuName
tell menu theMenuName
-- Click the menu item
click menu item theMenuItemName
end tell
end tell
end tell
end tell
end tell
return true
on error
return false
end try
EOF
