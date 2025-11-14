#!/bin/bash
read -p "Domínio: " d && read -p "ID: " i && read -p "Token: " t && mkdir -p /opt/sshorizon && cat > /etc/systemd/system/sshorizon-bot.service << EOF
[Unit]
Description=SSHorizon Bot Service
After=network.target

[Service]
Type=simple
ExecStart=/opt/sshorizon/bot \$d \$i \$t
Restart=always
RestartSec=5
User=root
WorkingDirectory=/opt/sshorizon

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload && systemctl enable sshorizon-bot.service --now && echo "Systemd criado e iniciado!"
