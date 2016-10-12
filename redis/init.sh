#!/bin/bash
(/usr/sbin/sshd -D &) && (redis-server /etc/redis/redis.conf)
