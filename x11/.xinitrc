#!/usr/bin/env bash

# settings
xset s off -dpms -b
setxkbmap -option ctrl:nocaps
xsetroot -cursor_name left_ptr

# theming
xrdb "${HOME}/.Xresources"

killall detect_monitor 2>/dev/null
detect_monitor &

dunst &
exec bspwm

# vim: ft=sh
