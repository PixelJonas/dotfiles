alias reload!='. ~/.zshrc'

alias cls='clear'

# Create directory and cd into it
mcd() { mkdir -p "$@" && cd "$_"; }

# cd up N levels (default 1)
up() {
  local levels=${1:-1}
  local path=""
  for _ in $(seq 1 "$levels"); do path="../$path"; done
  cd "$path" || return
}

# Show directory tree (falls back to find if tree not installed)
t() {
  if command -v tree &>/dev/null; then
    tree -aC -I '.git|node_modules|.DS_Store' "${@:-.}"
  else
    find "${1:-.}" -not -path '*/.git/*' -not -name '.DS_Store' | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
  fi
}

# Quick note to clipboard (macOS) or stdout
note() { echo "$*" | tee /dev/stderr | pbcopy 2>/dev/null || echo "$*"; }

# Show PATH entries one per line
path() { echo "$PATH" | tr ':' '\n'; }
