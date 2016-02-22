FROM gliderlabs/alpine
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

ENV APP_HOSTNAME nginx.local
ENV APP_ROOT /app
ENV NGINX_RUN_GROUP nginx
ENV NGINX_RUN_USER nginx
ENV DEPLOY_ENV prod

ENV APP_LOG_DIR $APP_ROOT/log
ENV APP_WEBROOT $APP_ROOT/html

ENV NGINX_LOG_FILE ${APP_LOG_DIR}/${APP_HOSTNAME}.access.log
ENV NGINX_ERROR_LOG_FILE ${APP_LOG_DIR}/${APP_HOSTNAME}.error.log

RUN apk --update add nginx && \
  rm -f /var/cache/apk/* && \
  mkdir -p ${APP_WEBROOT} && \
  mkdir -p ${APP_LOG_DIR}

COPY conf/nginx/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx/app.conf /etc/nginx/conf.d/app.conf

COPY scripts /scripts
RUN chmod -R 755 /scripts

WORKDIR /app
EXPOSE 80

ENTRYPOINT ["/scripts/run.sh"]
