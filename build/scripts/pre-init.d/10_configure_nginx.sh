#!/usr/bin/env sh
sed -i "s|APP_HOSTNAME|$APP_HOSTNAME|g" "$NGINX_APP_CONF_FILE"
sed -i "s|APP_WEBROOT|$APP_WEBROOT|g" "$NGINX_APP_CONF_FILE"
sed -i "s|DEPLOY_ENV|$DEPLOY_ENV|g" "$NGINX_APP_CONF_FILE"
sed -i "s|NGINX_CONFD_DIR|$NGINX_CONFD_DIR|g" "$NGINX_CONF_FILE"
sed -i "s|NGINX_CONFD_DIR|$NGINX_CONFD_DIR|g" "$NGINX_APP_CONF_FILE"
sed -i "s|NGINX_CONFD_SLUG|$NGINX_CONFD_SLUG|g" "$NGINX_CONF_FILE"
sed -i "s|NGINX_CONFD_SLUG|$NGINX_CONFD_SLUG|g" "$NGINX_APP_CONF_FILE"
sed -i "s|NGINX_ERROR_LOG_FILE|$NGINX_ERROR_LOG_FILE|g" "$NGINX_APP_CONF_FILE"
sed -i "s|NGINX_LOG_FILE|$NGINX_LOG_FILE|g" "$NGINX_APP_CONF_FILE"
sed -i "s|NGINX_RUN_USER|$NGINX_RUN_USER|g" "$NGINX_CONF_FILE"
