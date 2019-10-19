#!/bin/bash


pv_volume=$(lsblk -o NAME -dsn | grep -vx '.\{4,\}')
vg_group="vg_"`hostname`

for i in $pv_volume
do

echo item: $i
pvcreate /dev/$i

done

cd /dev && vgcreate $vg_group $pv_volume && cd -

lvcreate -l 20%VG $vg_group


folders=`ls /dev/$vg_group`

for j in $folders
do

sudo mkfs.ext4 -F /dev/$vg_group/$j
mkdir /mnt/$j
mount /dev/$vg_group/$j /mnt/$j
done
