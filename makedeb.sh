#!/bin/sh

# makedeb -- A guerilla Debian package generator.

[ $# -eq 0 -o "x$1" = "x--help" ] && set -- help

exec make -f- -- "$@" _SCRIPT="$0" <<'EOF'

BUILD = build
DATA = data

.PHONY: help

help:
	@echo "USAGE: $(_SCRIPT) help|clean|<something>.deb [VAR=value ...]"
	@echo "Variables:"
	@echo "  BUILD: The directory where to place temporary build files"
	@echo "  DATA: The directory to take package data from"

EOF
