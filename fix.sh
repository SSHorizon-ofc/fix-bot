read -p "Domínio: " d && read -p "ID: " i && read -p "Token: " t && mkdir -p /opt/sshorizon && cat > /etc/systemd/system/sshorizon-bot.service << EOF && systemctl daemon-reload && systemctl enable sshorizon-bot.service && systemctl start sshorizon-bot.service && echo "✅ Systemd criado e iniciado!"
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
