#!/usr/bin/env sh
START_TIME=`cat /tmp/start_time`
NOW=`date +%s`
STARTUP_TIME=`expr $NOW - $START_TIME`

echo "-------------------" >> /tmp/deploy_time.txt
printf "Total : ${STARTUP_TIME}s\n" >> /tmp/deploy_time.txt

printf "\nDeployment Complete.\n-------------------\n"
cat /tmp/deploy_time.txt
printf "\n"
