#!/usr/bin/env bash

figlet Install Siem
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
curl -sO https://packages.wazuh.com/4.12/wazuh-install.sh && sudo bash ./wazuh-install.sh -a

#================
# Saida
#================
exit 0