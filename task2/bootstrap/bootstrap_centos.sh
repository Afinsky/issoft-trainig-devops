#!/bin/bash


#sudo yum update -yqq
sudo yum install -yqq git

git clone git@github.com:Afinsky/training-devops.git
git checkout module2
echo "---------------------------------------------------------------------"
cat training-devops/README.md
echo "---------------------------------------------------------------------"

echo "CentOS done!"
