#!/bin/bash

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

echo "[+] Instalando Tailscale..."

curl -fsSL https://tailscale.com/install.sh | sh

echo "[+] Inicializando Tailscale..."
sudo tailscale up

echo "[+] Tailscale ativo. Verifique o dashboard para autorizar o dispositivo."

#================
# Saida
#================
exit 0