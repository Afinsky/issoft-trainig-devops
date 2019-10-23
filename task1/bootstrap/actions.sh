#!/bin/bash

sudo -i -u vagrant bash << EOF
pwd && cd ~ && pwd

mkdir /home/vagrant/{current,new,old}
sudo cp -r --preserve=all /var/log/apt/* /home/vagrant/old
sudo cp -r --no-preserve=all /var/log/apt/* /home/vagrant/current

tar -czvf folders.tar.gz current new old

file /bin/* | grep -i shell | cut -d: -f1 > bin.txt

sudo su -c 'echo "nameserver 8.8.8.8" >> /etc/resolv.conf'

url_for_wget='https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.1.0-amd64-netinst.iso'
wget -c $url_for_wget




uptime > la.txt
df -ha /dev/sd* | grep -E '/dev/sd' > hdd.txt
ps aux > pl.txt
cat /proc/swaps > swap.txt
ls /dev/sd? > dev.txt
cat /proc/cpuinfo > cpu.txt
ps -fp 1 > pid.txt
ls /dev/sd?? > parts.txt
netstat -anp | grep :80 | grep ESTABLISHED
lsof -P -n -iTCP > tcp.txt
lsof -P -n -iUDP > udp.txt
netstat -nxp > usocket.txt
ip route > net.txt
netstat -s > nstat.txt
sudo hostnamectl set-hostname linuxdevops
cat /etc/resolv.conf | grep -w nameserver > dns.txt
cat /etc/netplan/01-netcfg.yaml | grep -A 1 nameserver >> dns.txt
EOF
