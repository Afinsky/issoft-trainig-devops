#!/bin/bash


KEY_NAME="for_nodes_key"

echo -e "\n\n\n" | ssh-keygen -b 4096 -f /home/vagrant/.ssh/$KEY_NAME -C "for-nodes"



eval "ssh-agent -s"
ssh-add /home/vagrant/.ssh/$KEY_NAME

touch /home/vagrant/.ssh/config && cat /tmp/config > /home/vagrant/.ssh/config && chmod 644 /home/vagrant/.ssh/config && rm -r /tmp/config

chown vagrant:vagrant /home/vagrant/.ssh/*

cp -a /home/vagrant/.ssh/$KEY_NAME.pub /vagrant/authorized_keys
