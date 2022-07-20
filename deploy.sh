#!/bin/bash

#####################################
# Update the variables here
#####################################

userAccount="appuser"
groupName="appgroup"

sudo useradd $userAccount 
sudo groupadd $groupName
sudo usermod -a -G $groupName $userAccount
echo $userAccount" ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers

#Install Docker & setting it up
sudo apt -y update
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt -y update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo systemctl enable docker 
sudo systemctl start docker 
sudo git clone https://github.com/rea-cruitment/simple-sinatra-app.git  /var/www/simple-sinatra-app
sudo docker compose up 
