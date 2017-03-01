#!/bin/sh

# makedeb -- A guerilla Debian package generator.

if [ $# -ge 2 ]; then
  P="$1"
  V="$2"
  shift 2
fi

exec make -f- -- "$@" _SCRIPT="$0" PKGNAME="$P" VERSION="$V" <<'EOF'

BUILD = build
DATA = data

.PHONY: help --help

help --help:
	@echo "USAGE: $(_SCRIPT) pkgname version [VAR=value ...]"
	@echo "       $(_SCRIPT) help|clean [VAR=value ...]"
	@echo "Variables:"
	@echo "  BUILD: The directory where to place temporary build files"
	@echo "  DATA: The directory to take package data from"

EOF
