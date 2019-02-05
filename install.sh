#!/bin/bash

create_link() {
    dst=$HOME/$1
    if [ -e $dst ] && [ ! -L $dst ]; then
        echo "$dst exists and is not a symbolic link, oops"
        return
    fi
    echo "linking $dst"
    ln -snf $(pwd)/$1 $dst
}

create_link .bashrc
create_link .bashrc.alias

create_link .vim
create_link .vimrc

create_link .xinitrc
create_link .Xresources

create_link .hushlogin

create_link .config/bspwm
create_link .config/dunst
create_link .config/sxhkd
create_link .config/polybar
create_link .config/compton.conf

for f in bin/*; do
    create_link $f
done
