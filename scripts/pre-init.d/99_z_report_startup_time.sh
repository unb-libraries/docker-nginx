#!/usr/bin/env sh
START_TIME=`cat /tmp/start_time`
NOW=`date +%s`
STARTUP_TIME=`expr $NOW - $START_TIME`
echo "-------------------" >> /tmp/deploy_time.txt
echo "Total : ${STARTUP_TIME}s" >> /tmp/deploy_time.txt
cat /tmp/deploy_time.txt
