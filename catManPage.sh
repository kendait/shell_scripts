#!/usr/local/bin/bash
#Name: catManPage.sh
#Author: Kenneth Dait
#Description: cats the specified man page to stout
#Created: Fri May 26 20:25:13 2017

targetCommand=$1
[ -z $targetCommand ]\
  && echo "ERROR: pass a command for man page" \
  && exit 1
tmpFile=/tmp/$date
man $targetCommand | col -b > $tmp
