SHELL := /bin/bash
SCRIPT := ./generate.sh

.PHONY: all nvim ghostty textual watch clean

all:
	@$(SCRIPT) all

nvim:
	@$(SCRIPT) lua

ghostty:
	@$(SCRIPT) ghostty

textual:
	@$(SCRIPT) textual

watch:
	@echo "Watching palette.sh and terminal.sh for changes..."
	@fswatch -o palette.sh terminal.sh | xargs -n1 -I{} $(SCRIPT) all

clean:
	@rm -f ../.config/nvim/lua/theme/palette.lua
	@rm -f ../.config/textual/theme.py
	@echo "Cleaned generated files"
