# Install Google Chrome
mkdir ~/Downloads
wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive apt install -y fonts-liberation libasound2 libnspr4 libnss3 xdg-utils libnss3 libgconf-2-4
sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install -y
rm -rf ~/Downloads
# SHM size for browsers
sudo echo "sudo mount -t tmpfs -o size=2g tmpfs /dev/shm" > /usr/local/sbin/shm-mount-entrypoint
sudo chmod +x /usr/local/sbin/shm-mount-entrypoint
###USAGE: DEBUG=pw:browser google-chrome --no-sandbox --disable-gpu
