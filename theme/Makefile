SHELL := /bin/bash
SCRIPT := ./generate.sh

.PHONY: all nvim ghostty watch clean

all:
	@$(SCRIPT) all

nvim:
	@$(SCRIPT) lua

ghostty:
	@$(SCRIPT) ghostty

watch:
	@echo "Watching palette.sh and terminal.sh for changes..."
	@fswatch -o palette.sh terminal.sh | xargs -n1 -I{} $(SCRIPT) all

clean:
	@rm -f ../.config/nvim/lua/theme/palette.lua
	@echo "Cleaned generated files"
