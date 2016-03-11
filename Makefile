prefix = /usr/local
bindir = $(prefix)/bin/
mandir = $(prefix)/share/man/man1/
INSTALL = install -c

all: install

install:
	$(INSTALL) *.sh git-webkit2png $(bindir)
	$(INSTALL) git-webkit2png.1 $(mandir)
