.PHONY: install update link unlink macos test help

DOTFILE_HOME := $(shell pwd)

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

install: ## Bootstrap a fresh machine (pre-reqs → symlinks → packages)
	@bash script/bootstrap

update: ## Re-run installers and refresh symlinks without full bootstrap
	@bash script/install

link: ## Symlink all *.symlink files into $HOME
	@bash script/link-dotfiles

unlink: ## Remove symlinks that point into this dotfiles directory
	@bash script/unlink-dotfiles

macos: ## Apply macOS system defaults (macOS only)
	@bash macos/install.sh

test: ## Verify all symlinks are intact
	@bash script/test-symlinks
