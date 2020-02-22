#!/bin/sh

FONTDIR=$HOME/fonts

xrandr --dpi 192

mkdir -p $FONTDIR && xset +fp $FONTDIR

#xsetroot -cursor_name left_ptr
xset fp rehash
xset dpms 180 300
xset -b
xss-lock -- sxlock &

setxkbmap -option ctrl:nocaps
autorandr -c

exec bspwm
