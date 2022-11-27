# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -a'
export EDITOR=nvim
PS1='[\u@\h \W]\$ '
#. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin/:$PATH"

# ALIASES
alias updates='paru -Syu && flatpak update'
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


# Color
export PS1="\[\e[31m\][\[\e[m\]\[\e[33m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[36m\]\h\[\e[m\] \[\e[35m\]\w\[\e[m\]\[\e[31m\]]\[\e[m\]$ "
