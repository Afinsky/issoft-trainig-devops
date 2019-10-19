#!/bin/bash


sed -i -e '0,/^pool.*/{s/^pool.*/server 1.by.pool.ntp.org\nserver 2.europe.pool.ntp.org\nserver 3.europe.pool.ntp.org /}' -i -e 's/^pool.*//g' /etc/ntp.conf

systemctl restart ntp
