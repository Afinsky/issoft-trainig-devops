#!/bin/bash


volumes=$(lsblk -o NAME,MOUNTPOINT -dsn | awk '$2=="" {print $1}')
vggrp="vg_"`hostname`

for i in $volumes
do

echo item: $i
sudo pvcreate /dev/$i -f
done

cd /dev
sudo vgcreate $vggrp $volumes
cd -