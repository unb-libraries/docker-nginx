#!/usr/bin/env sh
date +%s > /tmp/start_time
printf "Item|Run Time\n" > /tmp/deploy_time.txt
printf "----|--------\n" >> /tmp/deploy_time.txt
