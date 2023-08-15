#!/bin/bash
# This is the meta-installation script for my configs. Edit it if you like, and PR it if you think your modification is good.
# This is Arch Linux ONLY! No Gentoo anymore. Don't open issues if you aren't using Arch.

# SET UP FLAGS
copyonly=false
suckless=true
kde=true
while getopts 'csk' OPTION; do
	case "$OPTION" in
		c)  copyonly=true;; 
		s)  suckless=false;;
	esac
done

COLOR='\033[0;32m'
NOCOLOR='\033[0m'
JUEGOS=$(pwd)

# CONFORMATION
if $kde && $suckless && ! $copyonly; then
echo -e "${COLOR}This program will install dwm, dmenu, dwmblocks, and a few good utilities with my configs. READ THE SOURCE OF THIS SHELL SCRIPT! You can change what it installs with these flags:${NOCOLOR}"
echo -e "${COLOR}-c to only copy configs${NOCOLOR}"
echo -e "${COLOR}-s to exclude suckless${NOCOLOR}"
fi

# SOFTWARE INSTALL
if ! $copyonly; then
	echo -e "${COLOR}Install software for my configs.${NOCOLOR}"
	if [ -x "$(command -v pacman)" ]; then sudo pacman -S --needed neovim rustup kitty xorg playerctl pipewire neofetch flatpak doas git base-devel python-pip luajit curl xclip zsh meson sassc zsh-completions xcb-util-cursor redshift inkscape wget xorg-xmodmap picom xorg-setxkbmap xcursor-vanilla-dmz feh libxcb thunar p7zip flameshot blueman python-pynvim network-manager-applet cbatticon acpi ttf-hack acpilight && sudo chmod u+s "$(which fusermount)"
	else echo "${COLOR}Cannot figure out how to insatll software on whatever this OS is.${NOCOLOR}"; fi
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	git clone https://github.com/salman-abedin/devour.git && cd devour && sudo make install && cd .. && rm -rf devour/
	# ARCH SPECIFIC
	if [ -x "$(command -v pacman)" ]; then
		echo -e "${COLOR}Installing paru-bin from the AUR.${NOCOLOR}"
		mkdir paru-bin
		git clone https://aur.archlinux.org/paru-bin.git
		cd paru-bin
		makepkg -si
		cd ..
		rm -rf paru-bin/
		echo -e "${COLOR}Install more crap but from the AUR.${NOCOLOR}"
		paru -S --needed ttf-twemoji adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts ttf-ubraille devour
	else
		echo -e "${COLOR}Skipping AUR packages because you are not on arch.${NOCOLOR}"
	fi
else
	echo -e "${COLOR}Skipping software install.${NOCOLOR}"
fi

# ZSH
if ! $copyonly; then
	echo -e "${COLOR}Change the shell to zsh.${NOCOLOR}"
	export RUNZSH=no
	chsh -s /bin/zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
	echo -e "${COLOR}Skipping zsh install.${NOCOLOR}"
fi

# SUCKLESS STUFF
if $suckless; then
	mkdir -p ~/.config/dwm/
	sudo mkdir /usr/share/xsessions/
	sudo cp -v suckless/dwm.desktop /usr/share/xsessions/dwm.desktop
	sudo cp -v suckless/index.theme /usr/share/icons/default/index.theme
	cd suckless/dwm-src/
	sudo make clean install
	cd ../dmenu-src/
	sudo make clean install
	cd ../dwmblocks-src/
	sudo make clean install
	cd ../..
	git clone https://codeberg.org/Drogobo/x-disable-middle-click-paste.git
	cd x-disable-middle-click-paste/
	make && sudo make install
	cd .. && rm -rf x-disable-middle-click-paste/
else
	echo -e "${COLOR}Skipping suckless install.${NOCOLOR}"
fi

# COPY CONFIGS / ENV VARIABLES
echo -e "${COLOR}Copy configs to correct dirs.${NOCOLOR}"
sudo cp -v -r paru.conf doas.conf pacman.conf /etc/
sudo cp -v bashrc /etc/bash/bashrc
sudo cp -v bashrc /etc/bash.bashrc
sudo cp -v stylish/cursor/index.html /usr/share/icons/default/index.theme
sudo cp -v .XCompose ~/.XCompose
cp -v dmenuunicode ~/.local/bin
cp -v -r .config/ .oh-my-zsh/ .zshrc ~/
mkdir ~/Pictures
cp -v Woods.jpg ~/Pictures/
sudo ln -s /usr/bin/kitty /usr/bin/gnome-terminal
sudo ln -s /usr/bin/kitty /usr/bin/xfce4-terminal
xdg-mime default kitty.desktop text/x-shellscript
xdg-mime default kitty.desktop text/plain
xdg-mime default thunar.desktop inode/directory
cd ~/.local/share
rm emoji*
wget https://raw.githubusercontent.com/LukeSmithxyz/voidrice/master/.local/share/larbs/emoji
wget https://gitlab.com/wavexx/acpilight/-/raw/master/90-backlight.rules && sudo mv 90-backlight.rules /etc/udev/rules.d/90-backlight.rules
cd "${JUEGOS}"

if ! $copyonly; then
# PAPIRUS
	cd "${JUEGOS}"
	git clone https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git
	cd papirus-icon-theme/
	cp ../papirus.diff ./papirus.diff
	git apply papirus.diff
	cd tools/
	./build_color_folders.sh
	cd ..
	sudo make install
	cd ..
	rm -rf papirus-icon-theme/
	cd "${JUEGOS}"
	chmod +x papirus-folders
	./papirus-folders -C luke --theme Papirus-Dark
# GTK THEME
	cd "${JUEGOS}"
	git clone https://codeberg.org/Drogobo/luke-theme
	cd luke-theme/
	meson setup --prefix=/usr -Dthemes=gtk2,gtk3,gtk4 -Dvariants=dark build/
	sudo meson install -C build/
	cd ..
	rm -rf luke-theme/
	cd "${JUEGOS}"
else
	echo -e "${COLOR}Skipping GTK and icon theme.${NOCOLOR}"
fi

if ! $copyonly; then
# UPDATE SYSTEM
	echo -e "${COLOR}Do a quick update to finalize.${NOCOLOR}"
	if [ -x "$(command -v apt)" ]; then doas apt update && doas apt upgrade
	elif [ -x "$(command -v pacman)" ]; then paru -Syu
	elif [ -x "$(command -v emerge)" ]; then doas emaint -a sync && doas emerge --ask --verbose --update --deep --changed-use @world
	else echo "Cannot figure out how to update on whatever this OS is."; fi
	flatpak update
	nvim --headless +PlugInstall +PlugUpdate +qa
	echo
else
	echo -e "${COLOR}Skipping update.${NOCOLOR}"
fi

# SPECIAL MESSAGE
echo -e "${COLOR}I also included a bonus wallpaper! It was copied to ~/Pictures. You might want to reboot before doing anything, so you don't accidentally break something.${NOCOLOR}"
