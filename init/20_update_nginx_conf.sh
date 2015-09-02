#!/usr/bin/env bash

if ! grep -q "daemon off;" /etc/nginx/nginx.conf;
then
  echo "daemon off;" >> /etc/nginx/nginx.conf
fi
