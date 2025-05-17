#!/bin/bash

echo "[+] Ativando política padrão do UFW..."
ufw default deny incoming
ufw default allow outgoing

echo "[+] Permitindo portas essenciais..."
ufw allow 65022 comment 'SSH Real'
ufw limit 65022/tcp comment 'Limitar tentativas de SSH'
ufw allow 80/tcp comment 'HoneyPot (WAF frontend)'
ufw allow 19999 comment 'NetData Monitor'
ufw allow 9000 comment 'Portainer Docker'
ufw allow 32768 comment 'File Browser'
ufw allow 3002 comment 'OpenSpeedTest'
ufw allow from 100.0.0.0/8 comment "Allow Tailscale network"
ufw allow from 192.168.122.0/24 comment "Rede local se necessário"

echo "[+] Habilitando o UFW..."
ufw enable

echo "[+] Exibindo regras ativas..."
ufw status numbered

# ---- OPCIONAL: Instalação e configuração básica do Fail2Ban ----

read -rp "Deseja instalar e configurar o Fail2Ban? (s/n): " opcao
if [[ "${opcao,,}" == "s" ]]; then
    echo "[+] Instalando o Fail2Ban..."
    apt update && apt install -y fail2ban

    echo "[+] Criando configuração personalizada..."
    cat <<EOF > /etc/fail2ban/jail.local
[DEFAULT]
bantime  = 600
findtime  = 300
maxretry = 5
backend = auto
ignoreip = 127.0.0.1/8

[sshd]
enabled = true
port = 65022
logpath = /var/log/auth.log
EOF

    echo "[+] Reiniciando Fail2Ban..."
    systemctl restart fail2ban
    systemctl enable fail2ban

    echo "[+] Status do Fail2Ban:"
    fail2ban-client status
fi
