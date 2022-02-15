FROM ghcr.io/unb-libraries/base:2.x
MAINTAINER UNB Libraries <libsupport@unb.ca>

ENV APP_STARTUP_CMD nginx
ENV APP_HOSTNAME nginx.local
ENV APP_WEBROOT $APP_ROOT/html
ENV NGINX_CONFD_DIR /etc/nginx/http.d
ENV NGINX_APP_CONF_FILE $NGINX_CONFD_DIR/app.conf
ENV NGINX_CONF_FILE /etc/nginx/nginx.conf
ENV NGINX_ERROR_LOG_FILE /proc/self/fd/2
ENV NGINX_LOG_FILE /proc/self/fd/2
ENV NGINX_PID_DIR /run/nginx
ENV NGINX_PID_FILE $NGINX_PID_DIR/nginx.pid
ENV NGINX_RUN_GROUP nginx
ENV NGINX_RUN_USER nginx

COPY ./build /build

RUN apk --no-cache add nginx && \
  mkdir -p "$NGINX_PID_DIR" && \
  chown "$NGINX_RUN_GROUP":"$NGINX_RUN_USER" "$NGINX_PID_DIR" && \
  mkdir -p "$APP_WEBROOT" && \
  rm -rf "$NGINX_CONFD_DIR/default.conf" && \
  $RSYNC_COPY /build/conf/nginx/nginx.conf "$NGINX_CONF_FILE" && \
  $RSYNC_COPY /build/conf/nginx/app.conf "$NGINX_APP_CONF_FILE" && \
  $RSYNC_COPY /build/scripts/ /scripts/ && \
  chmod -R 755 /scripts

WORKDIR /app
EXPOSE 80

ENTRYPOINT ["/scripts/run.sh"]

LABEL ca.unb.lib.generator="nginx" \
  com.microscaling.docker.dockerfile="/Dockerfile" \
  com.microscaling.license="MIT" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.description="docker-nginx is the base nginx image at UNB Libraries." \
  org.label-schema.name="nginx" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.url="https://github.com/unb-libraries/docker-nginx" \
  org.label-schema.vcs-ref="2.x" \
  org.label-schema.vcs-url="https://github.com/unb-libraries/docker-nginx" \
  org.label-schema.vendor="University of New Brunswick Libraries" \
  org.label-schema.version=$VERSION \
  org.opencontainers.image.source="https://github.com/unb-libraries/docker-nginx"
