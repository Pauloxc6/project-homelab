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
[[ ! -f "docker-compose.yml" ]] && { echo "[!] O arquivo docker-compose.yml não existe!" ; exit 1;}

echo "[+] Inicaindo docker-compose"
sleep 2s

docker-compose up -d

#================
# Saida
#================
exit 0