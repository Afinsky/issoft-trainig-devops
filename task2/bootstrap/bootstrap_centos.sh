#!/bin/bash


#sudo yum update -yqq

whoami
sudo -i -u vagrant bash << EOF


whoami
sudo yum install -y -q git

chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa

ssh-keyscan -H github.com >> ~/.ssh/known_hosts

#FUCK!!!
#ssh -T git@github.com 


echo "-------------------------------------"


git clone git@github.com:Afinsky/training-devops.git
cd training-devops
git checkout module2
cat README.md


echo "-------------------------------------"


echo "In"
whoami
EOF

echo "Out"
whoami

echo "CentOS done!"
