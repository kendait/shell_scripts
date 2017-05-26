#!/usr/local/bin/bash
#Name: listHomeDotFolders.sh
#Author: Kenneth Dait
#Description: formats and lists user directory dot config files dir directories
#Created: Fri May 26 16:02:21 2017

listArrayItemsByLine() {
	unset arr
	arr=($(echo $@))
	#echo ${#arr[@]} && return
	dotIndex=0
	dotCounter=1
	for dot in "${arr[@]}";
	do
		#echoStr="${dotIndex}: ${dot}"
		echoStr="${dot}"
		#echo $((dotCounter%3))
		if [[ $((dotCounter%3)) -ne 0 ]]; then
			#echo -ne "$echoStr\t"
			printf "%-20.15s\t" $echoStr
		elif [[ $((dotCounter%3)) -eq 0 ]]; then
			#echo -ne "$echoStr\n"
			printf "%-20.15s\n" $echoStr
		fi
		dotIndex=$((dotIndex+1))
		dotCounter=$((dotCounter+1))
	done

}

#gather non-directory dot files in array $dotFiles
dotFiles=($(ls -FGd ~/.* | \
	grep -Ev '\/\.+\/$' | \
	grep -v '~$' | grep -v "\.DS_Store" | \
	grep -v "\.CFUserTextEncoding" | \
	grep -v "\.Trash\/$" | \
	sed 's|/Users/kenpd/||' | \
	grep -v '\/$'))

#gather directory dot files in array $dotDirs
dotDirs=($(ls -FGd ~/.* | \
	grep -Ev '\/\.+\/$' | \
	grep -v '~$' | \
	grep -v "\.DS_Store" | \
	grep -v "\.CFUserTextEncoding" | \
	grep -v "\.Trash\/$" | \
	sed 's|/Users/kenpd/||' | \
	grep '\/$' | \
	sed 's/^.*$/[&]/' | \
	sed 's/\/\]$/\]/'))

echo -en "\nHOME DOT FILES:\n" && \
	listArrayItemsByLine ${dotFiles[@]}
echo -en "\n\nHOME DOT FILE DIRECTORIES:\n" && \
	listArrayItemsByLine ${dotDirs[@]}
echo -en "\n\n"
