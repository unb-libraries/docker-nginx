#!/bin/sh
sed -i "s|APP_HOSTNAME|$APP_HOSTNAME|g" /etc/nginx/conf.d/app.conf
sed -i "s|APP_LOG_DIR|$APP_LOG_DIR|g" /etc/nginx/conf.d/app.conf
sed -i "s|APP_WEBROOT|$APP_WEBROOT|g" /etc/nginx/conf.d/app.conf
sed -i "s|NGINX_RUN_USER|$NGINX_RUN_USER|g" /etc/nginx/nginx.conf
