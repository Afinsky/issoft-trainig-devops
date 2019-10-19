#!/bin/bash


sed -i -e '0,/^pool.*/{s/^pool.*/server node1 /}' -i -e 's/^pool.*//g' /etc/ntp.conf

systemctl restart ntp
