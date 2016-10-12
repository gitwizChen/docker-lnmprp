############################################################
# Dockerfile to build phalcon framework on php
# Based on php
# Author: wizChen
############################################################

FROM php:7.0.11-fpm

MAINTAINER wizChen <wizchenmail@gmail.com>

ENV PHALCON_VERSION 3.0.1

ENV PHP_REDIS_VERSION 3.0.0

ENV PHP_XDEBUG 2.4.1

ENV TERM dumb

COPY apt/sources.list /etc/apt/sources.list

# phalcon module
RUN \
  set -xe && \
  cd /tmp && \
  curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
  tar -zxvf v${PHALCON_VERSION}.tar.gz && \
  cd cphalcon-${PHALCON_VERSION}/build && \
  ./install && \
  echo "extension=phalcon.so" >> /usr/local/etc/php/conf.d/phalcon.ini && \
  cd ../.. && \
  rm -rf v${PHALCON_VERSION}.tar.gz cphalcon-${PHALCON_VERSION}

# redis module
RUN \
  cd /tmp && \
  curl -LO https://github.com/phpredis/phpredis/archive/${PHP_REDIS_VERSION}.tar.gz && \
  tar -zxvf ${PHP_REDIS_VERSION}.tar.gz && \
  cd phpredis-${PHP_REDIS_VERSION} && \
  phpize && \
  ./configure && \
  make && make install && \
  echo "extension=redis.so" >> /usr/local/etc/php/conf.d/redis.ini && \
  cd ../ && \
  rm -rf ${PHP_REDIS_VERSION}.tar.gz phpredis-${PHP_REDIS_VERSION}

# php-mysql module
RUN \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean && \
  sed -i -re 's/\w+\.archive\.ubuntu\.com/archive.ubuntu.com/g' /etc/apt/sources.list && \
  apt-get update && \
  cd /tmp && \
  apt-get install php7.0-mysql -y && \
  docker-php-ext-install pdo_mysql

# xdebug module
RUN \
  cd /tmp && \
  curl -LO https://xdebug.org/files/xdebug-${PHP_XDEBUG}.tgz && \
  tar -zxvf xdebug-${PHP_XDEBUG}.tgz && \
  cd xdebug-${PHP_XDEBUG} && \
  phpize && \
  ./configure --enable-xdebug && \
  make && make install && \
  echo "zend_extension=xdebug.so" >> /usr/local/etc/php/conf.d/xdebug.ini && \
  cd ../ && \
  rm -rf xdebug-${PHP_XDEBUG}.tar.gz xdebug-${PHP_XDEBUG}

RUN \
  apt-get update && \
  apt-get install vim wget curl -y && \
  # install ssh service
  apt-get install openssh-server -y && \
  mkdir -p /var/run/sshd

COPY init.sh /init.sh

EXPOSE 9000 22

WORKDIR /

CMD ["sh", "init.sh"]
