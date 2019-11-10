# systemd-steamlink-volume-normalize
## Description
Service to normalize the volume when Steam Big Picture mode is open

## Dependencies
This tool requires the following commands to be installed:
* xdotool
* xprop
* pamixer
* pactl


## Install
To install, you can either run `./install.sh` or you can manually copy `steam-bigpicture.service` to your user's systemd unit files directory, copy the `steam-big-pic-volume-ctrl.sh` script to some directory containing your user's `bin` directory, then update the `ExecStart` to point to `steam-big-pic-volume-ctrl.sh`

## Enable and run
`systemctl --user enable steam-bigpicture --now`
