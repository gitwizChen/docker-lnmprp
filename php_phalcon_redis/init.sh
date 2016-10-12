#!/bin/bash
(/usr/sbin/sshd -D &) && (php-fpm)
