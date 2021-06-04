# Make CTRL+D exit the current session

exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh
