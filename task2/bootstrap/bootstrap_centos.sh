#!/bin/bash


#sudo yum update -yqq

whoami
sudo -i -u vagrant bash << EOF

sudo yum install -y -q git

cat /tmp/authorized_keys >> ~/.ssh/authorized_keys

ssh-keyscan -H github.com >> ~/.ssh/known_hosts

git clone git@github.com:Afinsky/training-devops.git 

echo "In"
whoami
EOF

echo "Out"
whoami

echo "CentOS done!"
