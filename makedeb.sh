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
ARCH = all
MAINTAINER = none
DESC =

.PHONY: help --help clean

$(PKGNAME)-$(VERSION).deb: $(BUILD)/debian-binary $(BUILD)/control.tar.gz \
$(BUILD)/data.tar.gz
	ar rf $@ $^

help --help:
	@echo "USAGE: $(_SCRIPT) pkgname version [VAR=value ...]"
	@echo "       $(_SCRIPT) help|clean [VAR=value ...]"
	@echo "Variables:"
	@echo "  BUILD: The directory where to place temporary build files"
	@echo "  DATA: The directory to take package data from"
	@echo "  ARCH: Package architecture (defaults to \"all\")"
	@echo "  MAINTAINER: Package maintainer (defaults to \"none\")"
	@echo "  DESC: Package description (defaults to nothing)"

$(BUILD):
	mkdir -p $(BUILD)
$(DATA):
	@echo "Missing data directory ($(DATA)), cannot continue."
	@exit 2

$(BUILD)/debian-binary: | $(BUILD)
	echo 2.0 > $@

$(BUILD)/control: | $(BUILD)
	@echo "Package: $(PKGNAME)" > $@
	@echo "Version: $(VERSION)" >> $@
	@echo "Architecture: $(ARCH)" >> $@
	@echo "Maintainer: $(MAINTAINER)" >> $@
	@echo "Description: $(DESC)" >> $@
	@echo
	@echo "Edit $(BUILD)/control and re-run $(_SCRIPT)."
	@echo
	@exit 127

$(BUILD)/control.tar.gz: $(BUILD)/control
	cd $(BUILD) && tar cvvzf control.tar.gz control

$(BUILD)/data.tar.gz: $(DATA) | $(BUILD)
	cd $(DATA) && tar cvvzf $(shell readlink -f "$(BUILD)")/data.tar.gz .

clean:
	rm -rf $(BUILD)

EOF
