#!/bin/sh

# makedeb -- A guerilla Debian package generator.

[ $# -eq 0 -o "x$1" = "x--help" ] && set -- help

exec make -f- -- "$@" _SCRIPT="$0" <<'EOF'

.PHONY: help

help:
	@echo "USAGE: $(_SCRIPT) help|clean|<something>.deb [VAR=value ...]"

EOF
