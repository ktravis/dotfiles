#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

[[ -f ~/.extend.xsession ]] && . ~/.extend.xsession

setxkbmap -option ctrl:nocaps

killall detect_monitor 2>/dev/null
detect_monitor &

xrdb "${HOME}/.Xresources"
