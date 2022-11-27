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
echo -e "${COLOR}I also included a bonus wallpaper! It is in the same dir as this script. If you want to use it, it is called 'Woods.jpg'.${NOCOLOR}"
