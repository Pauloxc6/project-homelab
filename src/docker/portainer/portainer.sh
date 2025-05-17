#!/usr/bin/env bash

figlet Install OpenSpeedTest
echo "By: @Pauloxc6"

#=================================
# Testes Basicos
#=================================

[[ ! "$(comand -v curl)" ]] && { echo "[!] O programa curl não está instalado!" ; exit 1;}
[[ ! "$(comand -v sudo)" ]] && { echo "[!] O programa sudo não está instalado!" ; exit 1;}
[[ ! "$(comand -v wget)" ]] && { echo "[!] O programa wget não está instalado!" ; exit 1;}

[[ ! "$(comand -v docker)" ]] && { echo "[!] O programa docker não está instalado!" ; exit 1;}
[[ ! "$(comand -v docker-compose)" ]] && { echo "[!] O programa docker-compose não está instalado!" ; exit 1;}
#=================================
# MAIN
#=================================

# Instalção
echo "[+] Inicaindo docker-compose"
sleep 2s

echo "[+] Criando o volume portainer_data"
docker volume create portainer_data

echo "[+] Run Container"
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts

#================
# Saida
#================
exit 0