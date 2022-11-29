#!/bin/bash
# This is the meta-installation script for my configs. Edit it if you like, and PR it if you think your modification is good.
# There is currently no other distros supported besides arch, so add that and PR the the repo if you can.

COLOR='\033[0;32m'
NOCOLOR='\033[0m'
echo -e "${COLOR}Install software for my configs.${NOCOLOR}"
sudo pacman -S --needed neovim kitty plasma xorg neofetch flatpak firefox doas git base-devel 
echo -e "${COLOR}Installing paru-bin from the AUR.${NOCOLOR}"
mkdir paru-bin
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si
cd ..
rm -rf paru-bin/
echo -e "${COLOR}Copy configs to correct dirs.${NOCOLOR}"
sudo cp -v -r paru.conf doas.conf pacman.conf /etc/
cp -v -r .config/ .bashrc ~/
echo -e "${COLOR}Install more crap but from the AUR.${NOCOLOR}"
paru -S --needed ttf-hack ttf-twemoji adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts ttf-ubraille qalculate-gtk
echo -e "${COLOR}Do a quick update to finalize.${NOCOLOR}"
paru -Syu && flatpak update
echo -e "${COLOR}I also included a bonus wallpaper! It is going to be included by default, so feel free to change it. it will be located in ~/Pictures.${NOCOLOR}"
mkdir --parents ~/Pictures
cp Woods.jpg ~/Pictures
