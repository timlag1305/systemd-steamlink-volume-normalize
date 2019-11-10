#!/usr/bin/env sh

# Parameters:
# Timeout in seconds
TIMEOUT=1

bigpicture=-1

while true
do
	changed=-1
	found_bigpic=-1

	for pid in $(pidof steam)
	do
		for wmid in $(xdotool search --pid "$pid")
		do
			if xprop -id "$wmid" -notype | grep --quiet STEAM_BIGPICTURE
			then
				if [ $bigpicture -ne 0 ]
				then
					changed=0
				fi

				bigpicture=0
				found_bigpic=0
			fi
		done
	done

	if [ $found_bigpic -eq -1 ]
	then
		# Previously had Steam Big Picture open
		if [ $bigpicture -eq 0 ]
		then
			changed=0
			bigpicture=-1
		else
			# If we're not in big picture mode (and didn't have it open
			# last time we checked), get the latest mute/volume information
			muted=$(pamixer --get-mute)
			volume=$(pamixer --get-volume)
		fi
	fi

	# If big picture mode is running, set the volume
	if [ $changed -eq 0 ]
	then
		if [ $bigpicture -eq 0 ]
		then
			pactl set-sink-mute @DEFAULT_SINK@ false
			pactl set-sink-volume @DEFAULT_SINK@ 100%
		else
			pactl set-sink-mute @DEFAULT_SINK@ "$muted"
			pactl set-sink-volume @DEFAULT_SINK@ "$volume%"
		fi
	fi

	sleep $TIMEOUT
done
