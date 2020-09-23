.PHONY: install

all_files = $(wildcard .bashrc*) .vim/ .vimrc .Xresources .hushlogin $(wildcard .config/*/) $(wildcard bin/*)
targets = $(addprefix $(HOME)/,$(all_files))

services=clock.timer updates.timer tada.service

install: $(targets) services
$(HOME)/%: %
	@mkdir -p $(shell dirname $@)
	@[ -f $@ -a ! -L $@ ] && echo "$@: file exists and is not a symlink" && exit 1 || true
	ln -sfT $(shell pwd)/$(patsubst %/,%,$<) $(patsubst %/,%,$@)

daemon-reload:
	systemctl --user daemon-reload

services: daemon-reload $(services)
$(services):
	systemctl --user enable --now $@
