#!/bin/bash

# Function to download files using curl or wget
download() {
  if command -v curl &> /dev/null; then
    curl -fsSL "$1"
  elif command -v wget &> /dev/null; then
    wget -qO - "$1"
  else
    echo "Must install curl or wget to download $1" 1>&2
    return 1
  fi
}

sudo useradd openbox && \
    echo "openbox:openbox" | sudo chpasswd && \
    sudo usermod -aG sudo openbox

# Preconfigure xrdp to use US keyboard layout
echo "xrdp xrdp/default_keyboard string us" | sudo debconf-set-selections

# Install Openbox, XRDP, and other necessary tools
sudo DEBIAN_FRONTEND=noninteractive apt update
sudo DEBIAN_FRONTEND=noninteractive apt install -y kitty openbox
sudo DEBIAN_FRONTEND=noninteractive apt install -y dbus-x11 diodon
sudo DEBIAN_FRONTEND=noninteractive apt install -y xrdp

# Openbox configuration
sudo mkdir -p ~/.config/openbox/

# Create the xrdp-entrypoint script
sudo bash -c 'cat <<EOF > /usr/local/sbin/xrdp-entrypoint
#!/bin/bash

# Function to download files using curl or wget
download() {
  if command -v curl &> /dev/null; then
    curl -fsSL "\$1"
  elif command -v wget &> /dev/null; then
    wget -qO - "\$1"
  else
    echo "Must install curl or wget to download \$1" 1>&2
    return 1
  fi
}

# Download rc.xml if it does not exist
if [ ! -f ~/.config/openbox/rc.xml ]; then
  download https://raw.githubusercontent.com/rahuldhole/openbox/refs/heads/main/src/xrdp/rc.xml > ~/.config/openbox/rc.xml
  openbox --reconfigure
fi

# Restart the XRDP service
sudo service xrdp restart
EOF'

# Make the xrdp-entrypoint script executable
sudo chmod +x /usr/local/sbin/xrdp-entrypoint

# Run the xrdp-entrypoint script
/usr/local/sbin/xrdp-entrypoint