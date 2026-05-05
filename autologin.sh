#!/bin/bash
set -e

ENV_DIR="$HOME/env"
TTY="tty2"

USER_NAME="$(whoami)"

sudo mkdir -p /etc/systemd/system/getty@${TTY}.service.d

sudo tee /etc/systemd/system/getty@${TTY}.service.d/override.conf > /dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER_NAME --noclear %I \$TERM
EOF

cat > "$HOME/.bash_profile" <<EOF
if [ -z "\$DISPLAY" ] && [ "\$(tty)" = "/dev/$TTY" ]; then
    exec startx
fi
EOF

cat > "$HOME/.xinitrc" <<EOF
#!/bin/sh
exec /usr/bin/arexibo "$ENV_DIR"
EOF

chmod +x "$HOME/.xinitrc"

sudo chown -R "$USER_NAME:$USER_NAME" "$HOME/.bash_profile" "$HOME/.xinitrc"

sudo systemctl daemon-reexec
sudo systemctl daemon-reload

echo "Reboot empfohlen: sudo reboot"
