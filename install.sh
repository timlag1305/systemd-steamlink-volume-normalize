#!/usr/bin/env sh

if [ -z "$XDG_CONFIG_HOME" ]
then
	XDG_CONFIG_HOME="$HOME/.config"
fi

install --target-directory="$HOME/.local/bin" steam-big-pic-volume-ctrl.sh
install --mode=664 --target-directory="$XDG_CONFIG_HOME/systemd/user" steam-bigpicture.service
sed -i "/ExecStart=/ s#\$#$HOME/.local/bin/steam-big-pic-volume-ctrl.sh#" "$HOME/.config/systemd/user/steam-bigpicture.service"
