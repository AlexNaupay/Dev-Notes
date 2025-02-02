#!/bin/bash

DAY=`date +"%Y"`
DAY2=$(date)
DATE=$(date +"%Y-%m-%d")

echo "$DAY"
echo "$DAY2"
echo "$DATE"
echo "-----------------------"
echo "$(uname -r) $(whoami) `whoami`"

echo "`pwd`"