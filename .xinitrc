#!/bin/sh

#if cat /proc/modules | grep -q 'nvidia'; then
    #xrandr --setprovideroutputsource modesetting NVIDIA-0
    #xrandr --auto
    #xrandr --dpi 96
#else
    #xrandr --dpi 192
#fi
xrandr --dpi 192

#xrdb "${HOME}/.Xresources"

xset +fp ${HOME}/.fonts
xset fp rehash

xsetroot -cursor_name left_ptr
#xset 180 120
#xss-lock -- sxlock &

setxkbmap -option ctrl:nocaps
autorandr -c

exec bspwm
