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
cp .devcontainer/rc.xml ~/.config/openbox/
openbox --reconfigure

# Install Google Chrome
mkdir ~/Downloads
wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive apt install -y fonts-liberation libasound2 libnspr4 libnss3 xdg-utils libnss3 libgconf-2-4
sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install -y
rm -rf ~/Downloads
###USAGE: DEBUG=pw:browser google-chrome --no-sandbox --disable-gpu

# Install Edge
mkdir ~/Downloads
wget -P ~/Downloads https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_128.0.2739.67-1_amd64.deb
sudo dpkg -i ~/Downloads/microsoft-edge-stable_128.0.2739.67-1_amd64.deb
sudo apt --fix-broken install -y
rm -rf ~/Downloads
###USAGE: microsoft-edge-stable --no-sandbox

# Install VS Code
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code # or code-insiders
###USAGE: code --no-sandbox ./foldername


# SHM size for browsers
sudo mount -t tmpfs -o size=2g tmpfs /dev/shm

# Restart the XRDP service
sudo service xrdp restart
