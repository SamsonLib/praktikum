#!/bin/bash
set -e

XIBO_HOST=""
XIBO_KEY=""
ENV_DIR="$HOME/env"
TTY="tty2"

USER_NAME="$(whoami)"
HOME_DIR="/home/$USER_NAME"

curl -fsSL https://dl.xiboplayer.org/deb/GPG-KEY.asc | sudo tee /usr/share/keyrings/xiboplayer.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/xiboplayer.asc] https://dl.xiboplayer.org/deb/debian/trixie ./" | \
sudo tee /etc/apt/sources.list.d/xiboplayer.list

sudo apt update
sudo apt install -y arexibo

mkdir -p "$ENV_DIR"

arexibo --host \"$XIBO_HOST\" --key \"$XIBO_KEY\" $ENV_DIR
