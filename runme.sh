#!/bin/bash
#디렉토리 생성
mkdir -pv ./redis
mkdir -pv ./www
mkdir -pv ./mariadb/data
mkdir -pv ./portainer

#도커 설치
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y net-tools vim make binutils unzip
sudo apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o \
        /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get install -y docker-compose
sudo systemctl enable docker
sudo systemctl start docker
sudo docker network create web-service

#서비스 실행
sudo docker-compose up -d

#워드프레스 설치
#echo "Hello, World" > ./www/index.php
sudo groupmod -g 82 www-data
sudo usermod -u 82 www-data
wget https://ko.wordpress.org/latest-ko_KR.zip -P ./www
unzip ./www/latest-ko_KR.zip -d ./www
cp -R ./www/wordpress/* ./www
rm -rf ./www/wordpress ./www/latest-ko_KR.zip
sudo chown -R 82:82 www
sudo chmod 757 www