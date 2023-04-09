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
