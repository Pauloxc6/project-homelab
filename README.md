# Projeto Home Lab

Este é meu projeto de **Home Lab pessoal**, com foco em oferecer uma infraestrutura **simples, segura e funcional** para usuários com pouco conhecimento técnico. A ideia é permitir que qualquer pessoa possa armazenar arquivos com segurança, testar sua conexão, proteger aplicações web, monitorar o sistema e gerenciar containers de forma prática.

## Objetivos

- 🗄️ **Storage** simples para arquivos pessoais
- 🌐 **SpeedTest** local para testes de conexão
- 🛡️ **WAF (Web Application Firewall)** para proteger aplicações web
- 📊 **SIEM (Sistema de Monitoramento de Eventos de Segurança)** com alertas e logs centralizados
- 🧱 **Gerenciador de Containers** para facilitar o deployment de aplicações

---

## Topologia da Infraestrutura

A infraestrutura é dividida em dois servidores físicos e todo o acesso externo é controlado pelo **WAF**, que atua como um **reverse proxy**, redirecionando o tráfego para os serviços internos por portas específicas.

---

### 🖥️ Servidor 1 – 192.168.122.79

Responsável por **segurança da rede e análise de eventos**:

- 🔐 **WAF - SafeLine**  
  Reverse proxy e firewall de aplicações web que filtra e redireciona o tráfego.

- 🛡️ **SIEM - Wazuh**  
  Monitoramento de segurança, coleta e análise de logs.

- 🧱 **UFW (Firewall)**  
  Política de bloqueio/abertura de portas baseada em regras simples e eficazes.

- 🚫 **Fail2Ban**  
  Bloqueio automático de IPs com comportamento malicioso (ex: tentativas de login por força bruta).

| Serviço     | Porta | Caminho via WAF       | Descrição                                |
| ----------- | ----- | --------------------- | ---------------------------------------- |
| 🧱 Safeline | 19999 | `192.168.122.79:9443` | Monitoramento de sistema em tempo real   |
| 🖥️ Wazuh    | 9000  | `192.168.122.79:443`  | Gerenciador de containers Docker via GUI |

---

### 🖥️ Servidor 2 – 192.168.122.6

Responsável por **execução de aplicações e monitoramento**:

| Serviço          | Porta | Caminho via WAF        | Descrição                                    |
| ---------------- | ----- | ---------------------- | -------------------------------------------- |
| 🖥️ Netdata       | 19999 | `192.168.122.79:19999` | Monitoramento de sistema em tempo real       |
| 🧱 Portainer     | 9000  | `192.168.122.79:9000`  | Gerenciador de containers Docker via GUI     |
| 🗄️ FileBrowser   | 32768 | `192.168.122.79:32768` | Interface web para armazenamento de arquivos |
| 🌐 OpenSpeedTest | 3002  | `192.168.122.79:3002`  | Teste de velocidade da conexão via navegador |

- 🔐 **UFW** e **Fail2Ban** também habilitados neste servidor.

## 🐝 Honeypot Web

Para aumentar a segurança da infraestrutura, foi implementado um **Honeypot Web** simples que simula um servidor vulnerável, registrando acessos e tentativas de ataque para análise.

---

## 🔐 Acesso Seguro com Tailscale

O homelab utiliza o Tailscale para permitir acesso seguro e privado entre os dispositivos da infraestrutura.

- Cada servidor (WAF/SIEM/Containers) roda Tailscale
- Todo o acesso (como ao Portainer, FileBrowser e Netdata) é feito via hostname .ts.net
- O firewall (ufw) só permite conexões pela rede Tailscale (100.0.0.0/8)

### 🌐 Exemplo de acesso via domínio Tailscale

```bash
curl http://waf-server.ts.net:9000     # Acesso ao Portainer via VPN
```

⚠️ Todas as portas públicas estão bloqueadas — apenas acessos autorizados pela VPN do Tailscale são permitidos.

---

Essa topologia garante:

- 🔒 **Segurança** com isolamento de funções e firewall na borda
- ⚙️ **Modularidade**, com serviços segmentados por servidor
- 🔍 **Visibilidade** em tempo real com ferramentas de monitoramento

---

### 🌐 Fluxo Geral de Conexões

```
(Internet)
|
▼
[WAF - SafeLine - 192.168.122.79]
|
|---> /netdata → 192.168.122.6:19999
|---> /portainer → 192.168.122.6:9000
|---> /filebrowser → 192.168.122.6:32768
|---> /speedtest → 192.168.122.6:3002
|
└---> SIEM - Wazuh → 192.168.122.79 (local)
```

---

## Componentes Utilizados

| Sigla | Componente    | Função                                                       |
| ----- | ------------- | ------------------------------------------------------------ |
| WAF   | SafeLine      | Proteção contra ataques web (Web Application Firewall)       |
| SIEM  | Wazuh         | Coleta e análise de logs, monitoramento de segurança         |
| MO    | Netdata       | Monitoramento em tempo real dos servidores e containers      |
| GC    | Portainer     | Interface gráfica para gerenciar containers Docker           |
| ST    | FileBrowser   | Interface web para armazenamento e gerenciamento de arquivos |
| ST    | OpenSpeedTest | Ferramenta web para testar a velocidade da internet local    |

---

## Observações

- O WAF e o SIEM rodam em **servidores dedicados**, separados das aplicações.
- O Netdata compartilha o mesmo servidor dos containers para facilitar o monitoramento.
- As aplicações (como FileBrowser e SpeedTest) rodam em containers gerenciados pelo Portainer.
