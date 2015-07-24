FROM phusion/baseimage
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

CMD ["/sbin/my_init"]

RUN apt-get update && \
  DEBIAN_FRONTEND="noninteractive" apt-get install --yes nginx
RUN service nginx stop

ADD conf/default.conf /etc/nginx/sites-available/default

ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh

EXPOSE 80
