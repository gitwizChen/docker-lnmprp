#!/bin/bash
(/usr/sbin/sshd -D &) && (nginx -g "daemon off;")
