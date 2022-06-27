#!/usr/bin/env bash
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"

dir_downloads="$HOME/Downloads/programs"

softwares=(
  snapd
  flameshot
  nemo-dropbox
  steam-installer
  steam-devices
  steam:i386
)

sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

sudo dpkg --add-architecture i386

## Update packges
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir "$dir_downloads"
wget -c "$URL_GOOGLE_CHROME"       -P "$dir_downloads"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$dir_downloads"

# Install softwares with .deb files
sudo dpkg -i $dir_downloads/*.deb

# Install Beekeper Studio

## Install our GPG key
wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | sudo apt-key add -

## add our repo to your apt lists directory
echo "deb https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list

## Update apt and install
sudo apt update
sudo apt install beekeeper-studio

# Install softwares with apt
apt-get install git
for software in ${softwares[@]}; do
  if ! dpkg -l | grep -q $software; then # Insall only if not installed
    apt install "$software" -y
  else
    echo "[INSTALLED] - $software"
  fi
done

## Install softwares with Flatpak
flatpak install flathub com.visualstudio.code
flatpak install flathub com.spotify.Client
flatpak install flathub rest.insomnia.Insomnia
flatpak install flathub org.qbittorrent.qBittorrent
flatpak install flathub com.slack.Slack

# Setting of git
git config --global user.name "nicolasteofilo"
git config --global user.email "nicolasteofilodecastro@gmail.com"
git config --global core.editor "code"

## Install softwares with snap
sudo snap install photogimp

## Conclusion
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y