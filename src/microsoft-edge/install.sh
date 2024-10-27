# Install Edge
mkdir ~/Downloads
wget -P ~/Downloads https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_128.0.2739.67-1_amd64.deb
sudo dpkg -i ~/Downloads/microsoft-edge-stable_128.0.2739.67-1_amd64.deb
sudo apt --fix-broken install -y
rm -rf ~/Downloads
# SHM size for browsers
sudo mount -t tmpfs -o size=2g tmpfs /dev/shm
###USAGE: microsoft-edge-stable --no-sandbox