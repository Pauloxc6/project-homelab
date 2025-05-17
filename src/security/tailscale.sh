#!/bin/bash

echo "[+] Instalando Tailscale..."

curl -fsSL https://tailscale.com/install.sh | sh

echo "[+] Inicializando Tailscale..."
sudo tailscale up

echo "[+] Tailscale ativo. Verifique o dashboard para autorizar o dispositivo."
