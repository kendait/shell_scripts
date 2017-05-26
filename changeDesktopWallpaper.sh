#!/usr/local/bin/bash
#Name: changeDesktopWallpaper.sh
#Description: changes the displayed desktop wallpaper with OSA
#Created: Fri May 26 15:27:06 2017

##VARS
systemWallpaperDir="/Library/Desktop Pictures"
screencaptureDir="/Users/kenpd/Pictures/screencaptures"
captureName="$(date +%Y%m%d%H%M%S)_screencapture.png"
filePath="${screencaptureDir}/${captureName}"

##FUNCTIONS

silliness() {
    #screencapture "-t" format options (per man page):
    # pdf, jpg, tiff (png is the default)
  #screencapture -maCx -t "tiff" $filePath
  screencapture -maC -t "tiff" $filePath
  osascript <<eof
  tell application "Finder"
  set desktop picture to POSIX file "${filePath}"
  end tell
eof

}
#source for this script:
#http://osxdaily.com/2015/08/28/set-wallpaper-command-line-macosx/

if [ -z $1 ]; then
  #must provide image path
  echo "ERROR: must provide image path as argument"
  exit 1
elif [[ $1 == "-s" && $# -eq 1 ]]; then
  ##silliness
  silliness
  exit 0
else
  imagePath="$@"
  osascript <<eof
tell application "Finder"
set desktop picture to POSIX file "${imagePath}"
end tell
eof
fi
