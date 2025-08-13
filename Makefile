PROG ?= phrase
PREFIX ?= /usr
DESTDIR ?=
LIBDIR ?= $(PREFIX)/lib
SYSTEM_EXTENSION_DIR ?= $(LIBDIR)/password-store/extensions
MANDIR ?= $(PREFIX)/man

all:
	@echo "pass-${PROG} is a shell script and does not need compilation, it can be simply executed."
	@echo "To install it try \"make install\" instead."

install:
	install -d "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/"
	install -m0755 $(PROG).bash "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/$(PROG).bash"
	install -d "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)"
	install -d "$(DESTDIR)$(PREFIX)/share/wordlists/"
	install -m0644 wordlists/eff_large_wordlist_modified.txt "$(DESTDIR)$(PREFIX)/share/wordlists/eff_large_wordlist_modified.txt"
	install -d "$(DESTDIR)$(MANDIR)/man1" 
	install -m 0644 pass-$(PROG).1 "$(DESTDIR)$(MANDIR)/man1/pass-$(PROG).1"
	@echo
	@echo "pass-$(PROG) is installed succesfully"
	@echo

uninstall:
	rm -rf "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/$(PROG).bash" \
		"$(DESTDIR)$(MANDIR)/man1/pass-$(PROG).1" \
		"$(DESTDIR)$(PREFIX)/share/wordlists/eff_large_wordlist_modified.txt"

lint:
	shellcheck -s bash $(PROG).bash

.PHONY: install lint uninstall
