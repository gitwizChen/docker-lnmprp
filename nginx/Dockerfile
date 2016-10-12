############################################################
# Dockerfile to build nginx
# Based on debian
# Author: wizChen
############################################################

FROM debian:jessie

MAINTAINER wizChen <wizchenmail@gmail.com>

ENV NGINX_VERSION 1.11.5-1~jessie

ENV TERM dumb

COPY apt/sources.list /etc/apt/sources.list

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
	echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list && \
  apt-get update && \
	apt-get install --no-install-recommends --no-install-suggests -y \
						ca-certificates \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt \
						nginx-module-geoip \
						nginx-module-image-filter \
						nginx-module-perl \
						nginx-module-njs \
						gettext-base && \
	rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN \
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log

COPY nginx.conf /etc/nginx/nginx.conf

RUN \
  apt-get update && \
  apt-get install vim wget curl -y && \
  # install ssh service
  apt-get install openssh-server -y && \
  mkdir -p /var/run/sshd

COPY init.sh /init.sh

EXPOSE 80 443 22

WORKDIR /

CMD ["sh", "init.sh"]
