#!/bin/bash

sudo useradd openbox && \
    echo "openbox:openbox" | sudo chpasswd && \
    sudo usermod -aG sudo openbox

# Preconfigure xrdp to use US keyboard layout
echo "xrdp xrdp/default_keyboard string us" | sudo debconf-set-selections

# Install Openbox, XRDP, and other necessary tools
sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y kitty openbox
sudo DEBIAN_FRONTEND=noninteractive apt install -y  dbus-x11 diodon
sudo DEBIAN_FRONTEND=noninteractive apt install -y xrdp

# Openbox configuration
mkdir -p ~/.config/openbox/
wget -P ~/.config/openbox/ https://raw.githubusercontent.com/rahuldhole/openbox/refs/heads/main/src/xrdp/rc.xml

openbox --reconfigure

# Restart the XRDP service
sudo service xrdp restart
sudo echo "sudo service xrdp restart && diodon" >> /usr/local/sbin/xrdp-entrypoint
sudo chmod +x /usr/local/sbin/xrdp-entrypoint
