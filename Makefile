prefix = /usr/local
bindir = $(prefix)/bin/
INSTALL = install -c

all: install

install:
	$(INSTALL) *.sh git-webkit2png $(bindir)
