#!/bin/bash


mkdir /home/vagrant/{current,new,old}

cp -a /var/log/apt/* /home/vagrant/old

file /bin/* | grep -i shell | cut -d: -f1 > bin.txt

url_for_wget="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.1.0-amd64-netinst.iso"

wget -c $url_for_wget 
