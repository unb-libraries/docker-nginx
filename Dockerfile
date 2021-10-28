FROM alpine:3.13.6
MAINTAINER UNB Libraries <libsupport@unb.ca>

ENV APP_HOSTNAME nginx.local
ENV APP_ROOT /app
ENV APP_LOG_DIR $APP_ROOT/log
ENV APP_WEBROOT $APP_ROOT/html
ENV COLUMNS 160
ENV DEPLOY_ENV prod
ENV NGINX_ERROR_LOG_FILE /proc/self/fd/2
ENV NGINX_LOG_FILE /proc/self/fd/2
ENV NGINX_PID_DIR /run/nginx
ENV NGINX_PID_FILE $NGINX_PID_DIR/nginx.pid
ENV NGINX_RUN_GROUP nginx
ENV NGINX_RUN_USER nginx

COPY ./conf /conf
COPY ./scripts /scripts

RUN apk --no-cache add util-linux nginx patch && \
  mkdir -p ${NGINX_PID_DIR} && \
  chown ${NGINX_RUN_GROUP}:${NGINX_RUN_USER} ${NGINX_PID_DIR} && \
  mkdir -p ${APP_WEBROOT} && \
  mkdir -p ${APP_LOG_DIR} && \
  rm /etc/nginx/conf.d/default.conf && \
  cp /conf/nginx/nginx.conf /etc/nginx/nginx.conf && \
  cp /conf/nginx/app.conf /etc/nginx/conf.d/app.conf && \
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
  org.label-schema.vcs-ref="1.x" \
  org.label-schema.vcs-url="https://github.com/unb-libraries/docker-nginx" \
  org.label-schema.vendor="University of New Brunswick Libraries" \
  org.label-schema.version=$VERSION \
  org.opencontainers.image.source="https://github.com/unb-libraries/docker-nginx"
