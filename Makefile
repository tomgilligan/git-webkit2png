prefix = /usr/local
bindir = $(prefix)/bin/
mandir = $(prefix)/share/man/man1/
completiondir = $(prefix)/etc/bash_completion.d/
INSTALL = install -c

all: install

install:
	$(INSTALL) *.sh git-webkit2png $(bindir)
	$(INSTALL) git-webkit2png.1 $(mandir)
	$(INSTALL) git-webkit2png-completion.bash $(completiondir)/git-webkit2png
