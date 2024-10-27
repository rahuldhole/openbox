# Install Google Chrome
mkdir ~/Downloads
wget -P ~/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive apt install -y fonts-liberation libasound2 libnspr4 libnss3 xdg-utils libnss3 libgconf-2-4
sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
sudo apt --fix-broken install -y
rm -rf ~/Downloads
###USAGE: DEBUG=pw:browser google-chrome --no-sandbox --disable-gpu