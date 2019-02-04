#!/bin/sh

setxkbmap -option ctrl:nocaps
xrandr --dpi 192
xrdb "${HOME}/.Xresources"

xsetroot -cursor_name left_ptr
xset 180 120
xss-lock -- sxlock &

exec bspwm
