#!/bin/bash
read -p "Domínio: " d && read -p "ID: " i && read -p "Token: " t && mkdir -p /opt/sshorizon && cat > /etc/systemd/system/sshorizon-bot.service << 'EOF'
[Unit]
Description=SSHorizon Bot Service
After=network.target

[Service]
Type=simple
ExecStart=/opt/sshorizon/bot %d %i %t
Restart=always
RestartSec=5
User=root
WorkingDirectory=/opt/sshorizon

[Install]
WantedBy=multi-user.target
EOF
sed -i "s|%d|$d|g; s|%i|$i|g; s|%t|$t|g" /etc/systemd/system/sshorizon-bot.service
systemctl daemon-reload && systemctl enable sshorizon-bot.service --now && systemctl restart sshotizon-bot.service && echo "Systemd criado e iniciado!"
