#!/bin/zsh

run() {
	if ! pgrep -f "$1" ;
	then
		"$@"&
	fi
}

xset r rate 300 50;
run "picom"
run "redshift-gtk"
run "xdisablemiddleclickpaste"
run	"nm-applet"
run "blueman-applet"
run "cbatticon"
