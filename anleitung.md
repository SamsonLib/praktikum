
[Iso](https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2026-04-21/2026-04-21-raspios-trixie-arm64-lite.img.xz)

**SSH:** (Optional)
`sudo raspi-config`
> 3. Interface Options
> 4. SSH
> 5. Enable


```bash
curl -fsSL https://dl.xiboplayer.org/deb/GPG-KEY.asc | sudo tee /usr/share/keyrings/xiboplayer.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/xiboplayer.asc] https://dl.xiboplayer.org/deb/debian/trixie ./" | sudo tee /etc/apt/sources.list.d/xiboplayer.list
sudo apt update && sudo apt install arexibo
```

## Erster run
```bash
mkdir -p ~/env
arexibo --host "https://xibo.hs-wismar.de:443" --key "\"Keep_the_cr0wd_wEll_inf0rmed\"" ~/env/
```
Dann muss man im xibo-cms das Display authorisieren und danach kann man den Command erneut ausführen.

Ab jetzt kann man den client immer mit 
```bash
arexibo ~/env/
```
starten.

## Starten beim startup
```bash
#!/bin/bash

set -e

USER_NAME = "$(whoami)"
HOME_DIR = "/home/$USER_NAME"

echo "Configuring Autologin on tty2"

sudo mkdir -p /etc/systemd/system/getty@tty2.service.d

sudo tee /etc/systemd/system/getty@tty2.service.d/override.conf > /dev/null <<EOF  
[Service]  
ExecStart=  
ExecStart=-/sbin/agetty --autologin $USER_NAME --noclear %I $TERM  
EOF

cat > "$HOME_DIR/.bash_profile" <<'EOF'  
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty2" ]; then  
exec startx  
fi  
EOF

cat > "$HOME_DIR/.xinitrc" <<EOF  
#!/bin/sh  
exec /usr/bin/arexibo $HOME_DIR/env  
EOF

chmod +x "$HOME_DIR/.xinitrc"

sudo chown "$USER_NAME:$USER_NAME" "$HOME_DIR/.bash_profile" "$HOME_DIR/.xinitrc"

echo "Reloading systemd..."  
sudo systemctl daemon-reexec  
sudo systemctl daemon-reload

echo "Zum teste: sudo reboot"
```
