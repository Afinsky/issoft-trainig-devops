#!/bin/bash


#sudo yum update -yqq

sudo yum install -y -q git


# whoami
# sudo -i -u vagrant bash << EOF
# echo "In"
# whoami
# 
# ssh-keyscan -H github.com >> ~/.ssh/known_hosts
# ssh -T git@github.com
# git clone git@github.com:Afinsky/training-devops.git
# 
# EOF
# echo "Out"
# whoami
# 
echo "CentOS done!"
