zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent identities ~/.ssh/id_rsa ~/.ssh/secret/id_rsa

# Transparently enable trzsz (trz/tsz) file transfer over any ssh session,
# on hosts where the trzsz client is installed (e.g. midgard).
command -v trzsz &>/dev/null && alias ssh='trzsz ssh'