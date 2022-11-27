echo "Install software for my configs."
sudo pacman -S --needed neovim kitty plasma xorg neofetch flatpak firefox doas git base-devel 
echo "Installing paru-bin from the AUR."
mkdir paru-bin
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si
cd ..
rm -rf paru-bin/
echo "Copy configs to correct dirs."
sudo cp -v -r paru.conf doas.conf pacman.conf /etc/
cp -v -r .config/ .bashrc ~/
echo "Install more crap but from the AUR."
paru -S --needed ttf-hack ttf-twemoji adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts ttf-ubraille qalculate-gtk
echo "Do a quick update to finalize."
paru -Syu && flatpak update
echo "I also included a bonus wallpaper! It is in the same dir as this script. If you want to use it, it is called 'Woods.jpg'."
