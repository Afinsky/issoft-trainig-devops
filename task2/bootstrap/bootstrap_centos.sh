#!/bin/bash


#sudo yum update -yqq

whoami
sudo -i -u vagrant bash << EOF


whoami
sudo yum install -y -q git

#cat /tmp/authorized_keys >> ~/.ssh/authorized_keys


chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa

ssh-keyscan -H github.com >> ~/.ssh/known_hosts

#FUCK!!!
#ssh -T git@github.com 

echo "-------------------------------------"
cd ~
pwd
echo "-------------------------------------"


sudo runuser -l vagrant -c 'git clone git@github.com:Afinsky/trash-experience-etc.git'

while [ ! -d ~/training-devops ] 
do 

git clone git@github.com:Afinsky/training-devops.git 

done

echo "-------------------------------------"


echo "In"
whoami
EOF

echo "Out"
whoami

echo "CentOS done!"
