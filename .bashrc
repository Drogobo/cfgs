# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -a'
export EDITOR=nvim
PS1='[\u@\h \W]\$ '
#. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin/:$PATH"
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library

# ALIASES

alias updates='
if [ -x "$(command -v apt)" ]; then doas apt update && doas apt upgrade
elif [ -x "$(command -v pacman)" ]; then paru -Syu
elif [ -x "$(command -v emerge)" ]; then doas emaint -a sync && doas emerge --ask --verbose --update --deep --changed-use @world
else echo "Cannot figure out how to update on whatever this OS is.">&2; fi
flatpak update
nvim --headless +PlugInstall +PlugUpdate +qa
'
alias nim='nvim'
alias btw='neofetch'
alias orphankiller='paru -Qtdq | paru -Rns - '
alias findproc='ps aux | grep -i'
alias killde='kquitapp5 plasmashell && kstart5 plasmashell'
alias 0x0="curl -F 'file=@-' 0x0.st"
alias day='date +"%B %d, %Y"'
findpid() {
	pgrep -f -i "$1" | xargs echo 
}
killa() {
	kill -9 $(findpid "$1")
}
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Color
export PS1="\[\e[31m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\] \[\e[35m\]\w\\[\033[33m\]\$(parse_git_branch)\[\e[m\]\[\e[31m\]]\[\e[m\]$ "
