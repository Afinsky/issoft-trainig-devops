#!/bin/bash


list_for_scan=$(grep -v `hostname` /etc/hosts | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" | grep -v '127.*')


for i in $list_for_scan
do

echo item: $i
ssh-keyscan -H $i >> /home/vagrant/.ssh/known_hosts

done

chmod 644 /home/vagrant/.ssh/known_hosts
