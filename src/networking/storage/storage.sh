#!/usr/bin/env bash

figlet Install FileBrowser
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

echo "[+] Criando o volume locais"
sleep 2s
mkdir /srv/{files,config}
chmod 777 /srv/{files,config}

# Instalção
[[ ! -f "docker-compose.yml" ]] && { echo "[!] O arquivo docker-compose.yml não existe!" ; exit 1;}

echo "[+] Inicaindo docker-compose"
sleep 2s

docker-compose up -d

#================
# Saida
#================
exit 0