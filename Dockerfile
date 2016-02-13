FROM phusion/baseimage
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV WEBTREE_ROOT /usr/share/nginx
ENV WEBTREE_WEBROOT /usr/share/nginx/html

RUN locale-gen en_US.UTF-8
RUN apt-get update && \
  DEBIAN_FRONTEND="noninteractive" apt-get install --yes nginx && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  service nginx stop

ADD conf/nginx/default.conf /etc/nginx/sites-available/default

CMD ["/sbin/my_init"]
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run && \
  chmod -v +x /etc/my_init.d/*.sh

EXPOSE 80
