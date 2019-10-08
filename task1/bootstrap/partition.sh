#!/bin/bash


disks=$(lsblk -o NAME -dsn | grep -vx '.\{4,\}')

for i in $disks
do

echo item: $i

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo fdisk /dev/$i
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk
  +2G # Size
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  a # make a partition bootable
  1 # bootable partition is partition 1 -- /dev/sda1
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

done
