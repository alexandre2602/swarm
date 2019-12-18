#!/bin/bash

while [ "$(ssh -o stricthostkeychecking=no root@192.168.33.10 which docker)" == "" ]; do
	sleep 1;
done

scp -r root@192.168.33.10:/var/cache/apt/archives /var/cache/apt/

apt-get install -y vim apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
