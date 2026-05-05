## 1. Create the user

```bash
sudo adduser xibo
sudo usermod -aG video,audio,input,render xibo
```
---

## 2. Create environment directory

```bash
sudo -u xibo mkdir -p /home/xibo/env
```

---

## 3. Install Arexibo
```bash
sudo apt update
sudo apt install xorg xinit
```

---

## 4. First manual setup (verry importand)

```bash
sudo -u xibo /usr/bin/arexibo --host "HOST" --key "KEY" /home/xibo/env
```
---

# 5. Enable Autologin

```bash
#!/bin/bash
set -e

USER_NAME="xibo"
TTY="tty1"
CONF_DIR="/etc/systemd/system/getty@${TTY}.service.d"
CONF_FILE="${CONF_DIR}/autologin.conf"

sudo mkdir -p "$CONF_DIR"

sudo tee "$CONF_FILE" > /dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER_NAME --noclear %I \$TERM
EOF

sudo systemctl daemon-reexec

sudo systemctl restart getty@${TTY}.service

echo "Autologin enabled for '$USER_NAME' on $TTY"
```

---

# 6. SYSTEMD service

```bash
sudo tee /etc/systemd/system/arexibo.service > /dev/null <<'EOF'
[Unit]
Description=Arexibo Autostart
Wants=network-online.target
After=network-online.target systemd-user-sessions.service

[Service]
Type=simple

User=xibo
Group=xibo

Environment=HOME=/home/xibo
Environment=NO_AT_BRIDGE=1

# Start X + Arexibo
ExecStart=/usr/bin/xinit /usr/bin/arexibo /home/xibo/env -- :0 vt2 -s 0 -ac -nolisten tcp -dpms

Restart=always
RestartSec=2

StartLimitIntervalSec=60
StartLimitBurst=5

[Install]
WantedBy=multi-user.target
EOF
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable arexibo.service
```
