#!/bin/bash

lhst="http://localhost"
if [ -z $1 ]; then open $lhst":80"; 
else case $1 in
	home|h) open $lhst"/~"$USER;;
	phpmyadmin) open $lhst"/~"$USER/phpmyadmin;;
esac
fi
