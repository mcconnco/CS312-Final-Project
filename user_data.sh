#! bin/bash

sudo yum -y update;
sudo rpm --import https://yum.corretto.aws/corretto.key;
sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo;
sudo yum install -y java-17-amazon-corretto-devel.x86_64;
sudo mkdir /usr/local/minecraft/;
sudo chown ec2-user etc/systemd/system/;
sudo wget -O /etc/systemd/system/minecraft.service https://raw.githubusercontent.com/mcconnco/CS312-Final-Project/main/minecraft.service;
sudo wget -O /usr/local/minecraft/server.jar https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar;
sudo chown ec2-user /usr/local/minecraft/;
cd /usr/local/minecraft/;
java -Xmx1024M -Xms1024M -jar server.jar nogui;
sed -i 's/false/true/' eula.txt;
sudo systemctl enable minecraft.service;
sudo systemctl start minecraft.service;
