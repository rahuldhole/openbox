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
# SHM size for browsers
sudo echo "sudo mount -t tmpfs -o size=2g tmpfs /dev/shm" > /usr/local/sbin/shm-mount-entrypoint
sudo chmod +x /usr/local/sbin/shm-mount-entrypoint
###USAGE: code --no-sandbox ./foldername
