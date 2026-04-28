#!/usr/bin/env bash
# Install common Go development tools

if ! command -v go &>/dev/null; then
  echo "go not found, skipping Go tools installation"
  exit 0
fi

tools=(
  "golang.org/x/tools/gopls@latest"            # LSP server
  "github.com/go-delve/delve/cmd/dlv@latest"   # debugger
  "golang.org/x/tools/cmd/goimports@latest"    # import formatter
  "github.com/golangci/golangci-lint/cmd/golangci-lint@latest" # linter
  "mvdan.cc/gofumpt@latest"                     # stricter gofmt
  "github.com/fatih/gomodifytags@latest"        # struct tag editor
  "github.com/josharian/impl@latest"            # interface stub generator
)

for tool in "${tools[@]}"; do
  name=$(basename "${tool%@*}")
  if command -v "$name" &>/dev/null; then
    echo "  already installed: $name"
  else
    echo "  installing: $tool"
    go install "$tool"
  fi
done
