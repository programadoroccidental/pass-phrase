PROG ?= phrase
PREFIX ?= /usr
DESTDIR ?=
LIBDIR ?= $(PREFIX)/lib
SYSTEM_EXTENSION_DIR ?= $(LIBDIR)/password-store/extensions

all:
	@echo "pass-${PROG} is a shell script and does not need compilation, it can be simply executed."
	@echo "To install it try \"make install\" instead."

install:
	install -d "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/"
	install -m0755 $(PROG).bash "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/$(PROG).bash"
	install -d "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)"
	install -d "$(DESTDIR)$(PREFIX)/share/wordlists/pass-phrase"
	install -m0644 eff_large_wordlist.txt "$(DESTDIR)$(PREFIX)/share/wordlists/pass-phrase/eff_large_wordlist.txt"
	@echo
	@echo "pass-$(PROG) is installed succesfully"
	@echo

uninstall:
	rm -rf "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/$(PROG).bash" \
		"$(DESTDIR)$(PREFIX)/share/wordlists/pass-phrase/"

lint:
	shellcheck -s bash $(PROG).bash

.PHONY: install lint uninstall
