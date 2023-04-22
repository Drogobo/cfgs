# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b)'

# Set up the prompt
setopt PROMPT_SUBST

# set shell colors
autoload -U colors && colors
PROMPT='%{$FG[009]%}[%{$FG[011]%}%n%{$FG[010]%}@%{$FG[014]%}%m %{$FG[013]%}%~%F{011}${vcs_info_msg_0_}%f%{$FG[009]%}]%{$FG[007]%}$%{$reset_color%} '
