#!/usr/bin/env bash
set -e
echo "########################################################"
echo "########################################################"
echo "########################################################"
echo "  Pós install De Distro baseadas em Ubuntu ou Fedora    "
echo "########################################################"
echo "########################################################"
echo "########################################################"
echo "OBS:NECESSARIO ACESSO ROOT PARA FAZER A ATUALIZAÇÃO"
echo "--------------------------------------------------------"

echo "   Qual a Sua Distro?   "
echo "--------------------------------------------------------"
echo "   Digite 1 Para Ubuntu "

echo "   Digite 2 Para Fedora "
echo "--------------------------------------------------------"
read ub

if [ "$ub" = 1 ]; then

  sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y  && sudo apt autoclean -y 
  sleep 2
  wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sleep 2
  dpkg -i google-chrome-stable_current_amd64.deb
  sleep 2
  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sleep 2
  sudo apt-get update -y && sudo apt-get install spotify-client -y
  sudo dpkg --add-architecture i386 
  wget -nc https://dl.winehq.org/wine-builds/winehq.key
  sudo apt-key add winehq.key
  sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ impish main'
  sudo apt update
  sudo apt install --install-recommends winehq-stable
  sudo apt install winetricks
else

  sudo echo "fastestmirror=true" >> /etc/dnf/dnf.conf
  sleep 1
  sudo echo "deltarpm=true" >> /etc/dnf/dnf.conf
  sleep 1
  sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sleep 2
  sudo dnf check-update -y && sudo dnf update -y && sudo dnf -y upgrade --refresh && sudo dnf autoremove -y
  sudo dnf install gnome-tweaks.noarch -y
  dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/35/winehq.repo
  dnf install winehq-stable

fi
