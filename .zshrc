# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="luke"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch x87_64"

# HISTORY
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# COOL BINDING STUFF
zstyle :compinstall filename '~/.zshrc'
bindkey -v
export KEYTIMEOUT=1
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^H" backward-kill-word
bindkey '^ ' autosuggest-accept
bindkey '^\' autosuggest-disable
bindkey '^[\' autosuggest-enable
autoload -Uz compinit
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
compinit

# GET THE NICE FAT BLOCK IN VI MODE
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# WEIRD THINGS THAT AREN'T DEFAULT FOR SOME REASON
alias ls='ls --color=auto -a'
#. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin/:$HOME/.config/dwm/:$HOME/.config/dwm/statusbar/:$HOME/.local/share/gem/ruby/3.0.0/bin:$HOME/.local/bin:$PATH"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
export HOME=/home/$USER

# ALIASES
alias updates="paru -Syu && flatpak update && nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"
alias n='nvim'
alias p='paru'
alias d='devour'
alias btw='fastfetch -s OS:Host:Kernel:Uptime:Packages:Shell:WM:Theme:Terminal:TerminalFont:CPU:GPU:Memory:Swap:Disk:Processes:Break:Colors'
alias orphankiller='paru -Qtdq | paru -Rns - '
alias findproc='ps aux | grep -i'
alias day='date +"%B %d, %Y"'
alias calendar='date +"%A, %B %d, %Y%n" && cal --months 3 --sunday --color=always --span'
alias makemykernel='doas cp /usr/src/linux/.config /usr/src/linux/backup.config && doas genkernel --makeopts=-j9 --kernel-config=/usr/src/linux/backup.config --menuconfig all && doas grub-mkconfig -o /boot/grub/grub.cfg'
findpid() {
	pgrep -f -i "$1" | xargs echo 
}
killa() {
	kill -9 $(findpid "$1")
}
