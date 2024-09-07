#!/bin/bash

# Set password for the existing vscode user
echo "vscode:vscode" | sudo chpasswd

# Preconfigure xrdp to use US keyboard layout
echo "xrdp xrdp/default_keyboard string us" | sudo debconf-set-selections

# Install Openbox, XRDP, and other necessary tools
sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y tilix openbox 
sudo DEBIAN_FRONTEND=noninteractive apt install -y xrdp

# Restart the XRDP service
sudo service xrdp start
