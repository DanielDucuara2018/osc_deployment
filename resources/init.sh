#!/bin/bash
#Installing Docker
sudo dnf check-update
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin git
sudo systemctl start docker
sudo systemctl status docker
sudo usermod -aG docker $(whoami)
sudo chmod 666 /var/run/docker.sock
git clone https://github.com/DanielDucuara2018/report_calculation.git /opt/report_calculation
git clone https://github.com/DanielDucuara2018/report_calculation_front.git /opt/report_calculation_front
docker compose -f /opt/report_calculation/docker-compose.yml up -d
docker compose -f /opt/report_calculation_front/docker-compose.dev.yml up -d
# sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /opt/report_calculation_front/resources/ssl/nginx-selfsigned.key -out /opt/report_calculation_front/resources/ssl/nginx-selfsigned.crt
# sudo openssl dhparam -out /opt/report_calculation_front/resources/ssl/dhparam.pem 2048