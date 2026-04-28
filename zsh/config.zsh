export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

fpath=($DOTFILE_HOME/functions $fpath)

autoload -U $DOTFILE_HOME/functions/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE        # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS     # allow functions to have local options
setopt LOCAL_TRAPS       # allow functions to have local traps
setopt HIST_VERIFY
setopt EXTENDED_HISTORY  # add timestamps to history
setopt SHARE_HISTORY     # share history across sessions (supersedes INC_APPEND_HISTORY)
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
# IGNORE_EOF removed — Ctrl+D exits via helper.zsh binding instead

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases
