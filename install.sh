#!/bin/bash
# This is the meta-installation script for my configs. Edit it if you like, and PR it if you think your modification is good.
# This supports 3 distros currently. Debian, Arch, and Gentoo. Do not create issues if you are not using DEBIAN, ARCH, OR GENTOO. You can PR my repo with a modification of this script but with support for another distro. However, I do NOT want whining about how this doesn't work on xyz distro.

COLOR='\033[0;32m'
NOCOLOR='\033[0m'
echo -e "${COLOR}Install software for my configs.${NOCOLOR}"
if [ -x "$(command -v apt-get)" ]; then sudo apt-get -y install doas flatpak neovim kitty xorg kde-standard git curl rust-all python neofetch fonts-hack fuse libfuse2 qalculate zsh zplug
elif [ -x "$(command -v pacman)" ]; then sudo pacman -S --needed neovim rustup kitty plasma-desktop xorg neofetch flatpak doas git base-devel python-pip luajit curl qalculate-gtk zsh zsh-completions && sudo chmod u+s "$(which fusermount)"
elif [ -x "$(command -v emerge)" ]; then sudo emerge -a app-editors/neovim dev-lang/rust-bin sys-apps/flatpak x11-terms/kitty app-admin/doas dev-vcs/git app-misc/neofetch net-misc/curl dev-python/pip media-fonts/hack kde-plasma/plasma-meta sys-fs/fuse:0 kde-plasma/plasma-pa kde-plasma/breeze-gtk sci-calculators/qalculate-gtk sys-kernel/genkernel app-shells/zsh app-shells/zsh-completions app-shells/gentoo-zsh-completions x11-misc/xclip
else echo "Cannot figure out how to insatll software on whatever this OS is.">&2; fi
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install --user neovim
if [ -x "$(command -v pacman)" ]; then
echo -e "${COLOR}Installing paru-bin from the AUR.${NOCOLOR}"
mkdir paru-bin
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si
cd ..
rm -rf paru-bin/
echo -e "${COLOR}Install more crap but from the AUR.${NOCOLOR}"
paru -S --needed ttf-hack ttf-twemoji adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts ttf-ubraille qalculate-gtk
else echo -e "${COLOR}Skipping AUR packages because you are not on arch.${NOCOLOR}">&2; fi
echo -e "${COLOR}Change the shell to zsh.${NOCOLOR}"
export RUNZSH=no
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo -e "${COLOR}Copy configs to correct dirs.${NOCOLOR}"
sudo cp -v -r paru.conf doas.conf pacman.conf /etc/
sudo cp -v bashrc /etc/bash/bashrc
sudo cp -v bashrc /etc/bash.bashrc
cp -v -r .config/ .bashrc .oh-my-zsh/ .zshrc ~/
echo -e "${COLOR}Do a quick update to finalize.${NOCOLOR}"
if [ -x "$(command -v apt)" ]; then doas apt update && doas apt upgrade
elif [ -x "$(command -v pacman)" ]; then paru -Syu
elif [ -x "$(command -v emerge)" ]; then doas emaint -a sync && doas emerge --ask --verbose --update --deep --changed-use @world
else echo "Cannot figure out how to update on whatever this OS is.">&2; fi
flatpak update
nvim --headless +PlugInstall +PlugUpdate +qa
echo
echo -e "${COLOR}I also included a bonus wallpaper! It is in the same dir as this script. If you want to use it, it is called 'Woods.jpg'. You might want to reboot before doing anything, so you don't accidentally break something.${NOCOLOR}"
