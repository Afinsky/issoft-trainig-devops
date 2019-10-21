#!/bin/bash


cat /tmp/keys/authorized_keys >> /home/vagrant/.ssh/authorized_keys
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
rm -rf /tmp/keys
echo "Client done!"
