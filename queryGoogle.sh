#!/usr/local/bin/bash
#Name: queryGoogle.sh
#Author: Kenneth Dait
#Description: sends google a query
#Created: Tue May 30 01:43:44 2017

queryString="$@"

queryString=$(echo $queryString | tr ' ' '+')
queryURL="https://www.google.com/?q=${queryString}"

open $queryURL
