#!/bin/bash

numberChars=$1

while [[ $numberChars -gt 0 ]]; do
	echo -n "."
	numberChars=$(echo $(($numberChars-1)))
done
