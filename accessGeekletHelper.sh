#!/usr/local/bin/bash
#Name: accessGeekletHelper.sh
#Description: a way to plugin to geektool
#Created: Fri May 26 15:17:38 2017


accessGeeklets() {
	osascriptHandler() {
		osascript <<eof
		tell application "Geektool Helper"
		geeklets
		end tell
eof
	}
	osascriptHandler | sed 's/,[[:space:]]/|/g' | tr '|' '\n'
}
