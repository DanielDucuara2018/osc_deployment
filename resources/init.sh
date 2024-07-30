#!/bin/bash
#Installing Docker
sudo dnf check-update
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin git
sudo systemctl start docker
sudo systemctl status docker
sudo usermod -aG docker $(whoami)
sudo chmod 666 /var/run/docker.sock
git clone https://github.com/DanielDucuara2018/audio_text_backend.git /opt/audio_text_backend
git clone https://github.com/DanielDucuara2018/audio_text_frontend.git /opt/audio_text_frontend
docker compose -f /opt/audio_text_backend/docker-compose.yml up -d
docker compose -f /opt/audio_text_frontend/docker-compose.dev.yml up -d
# sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /opt/audio_text_frontend/resources/ssl/nginx-selfsigned.key -out /opt/audio_text_frontend/resources/ssl/nginx-selfsigned.crt
# sudo openssl dhparam -out /opt/audio_text_frontend/resources/ssl/dhparam.pem 2048