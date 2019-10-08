#!/bin/bash


volumes=$(lsblk -o NAME,FSTYPE -dsn | awk '$2 == "" {print $1}')

for i in $volumes
do

echo item: $i
sudo mkfs.ext4 -F /dev/$i

done