#!/usr/bin/env sh
sed -i "s|NGINX_LOG_FILE|$NGINX_LOG_FILE|g" "${NGINX_APP_CONF_FILE}"
sed -i "s|NGINX_ERROR_LOG_FILE|$NGINX_ERROR_LOG_FILE|g" "${NGINX_APP_CONF_FILE}"
sed -i "s|APP_HOSTNAME|$APP_HOSTNAME|g" "${NGINX_APP_CONF_FILE}"
sed -i "s|APP_WEBROOT|$APP_WEBROOT|g" "${NGINX_APP_CONF_FILE}"
sed -i "s|NGINX_RUN_USER|$NGINX_RUN_USER|g" "${NGINX_CONF_FILE}"
