#!/bin/bash

apt update && apt install socat curl net-tools -y

read -p "Domínio: " d
read -p "ID: " i
read -p "Token: " t

if netstat -tuln | grep ':80 ' > /dev/null; then
    echo "❌ Porta 80 está ocupada. Libere a porta antes de continuar."
    exit 1
fi

if [ ! -f ~/.acme.sh/acme.sh ]; then
    curl https://get.acme.sh | sh
    ~/.acme.sh/acme.sh --register-account -m admin@$d
fi

~/.acme.sh/acme.sh --issue -d $d --standalone
mkdir -p /opt/sshorizon/certs
~/.acme.sh/acme.sh --install-cert -d $d --key-file /opt/sshorizon/certs/sshorizon.key --fullchain-file /opt/sshorizon/certs/sshorizon.pem

mkdir -p /opt/sshorizon

cat > /etc/systemd/system/sshorizon-bot.service << EOF
[Unit]
Description=SSHorizon Bot Service
After=network.target

[Service]
Type=simple
ExecStart=/opt/sshorizon/bot $d $i $t
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable sshorizon-bot.service
systemctl start sshorizon-bot.service
echo "✅ Systemd criado e iniciado!"
