#!/bin/sh
if [ "$DEPLOY_ENV" = "dev" ]; then
  sed -i "s|NGINX_LOG_FILE|/proc/self/fd/2|g" /etc/nginx/conf.d/app.conf
  sed -i "s|NGINX_ERROR_LOG_FILE|/proc/self/fd/2|g" /etc/nginx/conf.d/app.conf
else
  sed -i "s|NGINX_LOG_FILE|$NGINX_LOG_FILE|g" /etc/nginx/conf.d/app.conf
  sed -i "s|NGINX_ERROR_LOG_FILE|$NGINX_ERROR_LOG_FILE|g" /etc/nginx/conf.d/app.conf
fi

sed -i "s|APP_HOSTNAME|$APP_HOSTNAME|g" /etc/nginx/conf.d/app.conf
sed -i "s|APP_WEBROOT|$APP_WEBROOT|g" /etc/nginx/conf.d/app.conf
sed -i "s|NGINX_RUN_USER|$NGINX_RUN_USER|g" /etc/nginx/nginx.conf
