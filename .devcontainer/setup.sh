#!/bin/bash

# Set password for the existing vscode user
echo "vscode:vscode" | sudo chpasswd

# Preconfigure xrdp to use US keyboard layout
echo "xrdp xrdp/default_keyboard string us" | sudo debconf-set-selections

# Install Openbox, XRDP, and other necessary tools
sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y tilix openbox 
sudo DEBIAN_FRONTEND=noninteractive apt install -y xrdp


# Install Google Chrome
mkdir ~/Downloads
wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive apt install -y fonts-liberation libasound2 libnspr4 libnss3 xdg-utils libnss3 libgconf-2-4
sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install
rm -rf ~/Downloads

# Restart the XRDP service
sudo service xrdp start
