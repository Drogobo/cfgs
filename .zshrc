# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

bindkey -v
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^H" backward-kill-word

autoload -Uz compinit
compinit
# End of lines added by compinstall

# start of regular config

alias ls='ls --color=auto -a'
export EDITOR=nvim
PS1='[\u@\h \W]\$ '
#. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin/:$PATH"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
export HOME=/home/$USER

# ALIASES

alias updates='
if [ -x "$(command -v apt)" ]; then doas apt update && doas apt upgrade
elif [ -x "$(command -v pacman)" ]; then paru -Syu
elif [ -x "$(command -v emerge)" ]; then doas emaint -a sync && doas emerge --ask --verbose --update --deep --changed-use @world
else echo "Cannot figure out how to update on whatever this OS is.">&2; fi
flatpak update
nvim --headless +PlugInstall +PlugUpdate +qa
echo
'
alias n='nvim'
alias p='paru'
alias btw='neofetch'
alias orphankiller='
if [ -x "$(command -v apt)" ]; then doas apt autoremove
elif [ -x "$(command -v pacman)" ]; then paru -Qtdq | paru -Rns - 
elif [ -x "$(command -v emerge)" ]; then doas emerge --clean
else echo "Cannot figure out how to remove orphans on this OS.">&2; fi
'
alias findproc='ps aux | grep -i'
alias killde='kquitapp5 plasmashell && kstart5 plasmashell'
alias 0x0="curl -F 'file=@-' 0x0.st"
alias day='date +"%B %d, %Y"'
alias makemykernel='doas cp /usr/src/linux/.config /usr/src/linux/backup.config && doas genkernel --makeopts=-j9 --kernel-config=/usr/src/linux/backup.config --menuconfig all && doas grub-mkconfig -o /boot/grub/grub.cfg'
findpid() {
	pgrep -f -i "$1" | xargs echo 
}
killa() {
	kill -9 $(findpid "$1")
}
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b)'

# Set up the prompt
setopt PROMPT_SUBST

# set shell colors
autoload -U colors && colors
PROMPT='%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%m %{$fg[magenta]%}%~%F{yellow}${vcs_info_msg_0_}%f%{$fg[red]%}]%{$reset_color%}$ '
