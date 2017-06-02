tell application "Terminal"
	set openWindows to every window
	repeat with i from 1 to count of openWindows
		set this_window to item i of openWindows
		set visible of this_window to true
	end repeat
end tell
