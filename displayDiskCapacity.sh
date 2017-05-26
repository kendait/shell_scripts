#!/usr/local/bin/bash
#Name: displayDiskCapacity.sh
#Description: shows percentage full of the root drive
#Created: Fri May 26 15:13:25 2017


usedPercentage=$(df -H | grep "/dev/disk1" | awk '{print $5}')
echo "Mac HD: ${usedPercentage} full"
