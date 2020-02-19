.PHONY: install

all_files = $(wildcard .bashrc*) .vim/ .vimrc .Xresources .hushlogin $(wildcard .config/*/) $(wildcard bin/*)
targets = $(addprefix $(HOME)/,$(all_files))

install: $(targets)
$(HOME)/%: %
	@mkdir -p $(shell dirname $@)
	@[ -f $@ -a ! -L $@ ] && echo "$@: file exists and is not a symlink" && exit 1 || true
	ln -sf $(shell pwd)/$< $@
