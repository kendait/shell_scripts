#!/usr/local/bin/bash
#Name: leanderWeather.sh
#Description: pulls weather data from wunderground.com for Leander
#Created: Fri May 26 15:16:24 2017


w1=$(curl -s https://www.wunderground.com/q/zmw:78641.1.99999 | \
	grep -n "fi-clock" | sed 's/^.*<span>//' | \
	sed 's/<\/span>[[:space:]]/ /g' | \
	sed 's/<.*$//')

w2=$(curl -s https://www.wunderground.com/q/zmw:78641.1.99999 | \
	grep -n "Leander" | \
	grep "^22:" | \
	sed 's/^.*L/L/g' | \
	tr -d '&' | \
	tr -d ';' | \
	sed 's/\".*$//g')

echo $w1 && echo $w2
echo "(source: wunderground.com)"
