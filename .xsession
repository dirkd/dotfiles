#!/bin/bash

# start screensaver daemon
#gnome-screensaver

# set wallpaper
[ -x /usr/bin/feh ] && feh --bg-fill 'Pictures/02658_forest_2560x1440.jpg'

# start music player daemon
[ -x /usr/bin/mpd ] && mpd

# fix virtualbox keyboard (Caps_Lock as Menu)
if lsmod | grep -q 'vboxguest'; then
	xmodmap -e 'keysym Menu = Multi_key'
fi

urxvt &

DEFAULT_SESSION=mutter
case $1 in
	awesome|i3) exec $1 ;;
	*) exec $DEFAULT_SESSION ;;
esac
