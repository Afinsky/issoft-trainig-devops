#!/bin/bash


volumes=$(lsblk -o NAME,MOUNTPOINT -dsn | awk '$2=="" {print $1}')
vggrp="vg_"`hostname`

for i in $volumes
do

echo item: $i
sudo pvcreate /dev/$i -f
done

cd /dev && sudo vgcreate $vggrp $volumes && cd -

sudo lvcreate -l 40%VG $vggrp

dirs=`ls /dev/$vggrp`

for j in $dirs
do

sudo mkfs.ext4 -F /dev/$vggrp/$j
mkdir /mnt/$j
mount /dev/$vggrp/$j /mnt/$j
done
