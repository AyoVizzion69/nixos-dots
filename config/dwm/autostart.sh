#!/bin/sh
feh --bg-scale "$HOME/nixos-dots/walls/maxresdefault.jpg" &
picom -b --backend glx --config ~/.config/picom/picom.conf &
slstatus &

