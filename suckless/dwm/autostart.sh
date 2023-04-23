#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run xinput set-prop "Logitech G502 HERO SE" "libinput Accel Profile Enabled" 0 1 
run xinput set-prop "Logitech G502 HERO SE" "libinput Accel Speed" 0
run xset r rate 300 50
run setxkbmap -option caps:swapescape
run feh --bg-scale ~/Pictures/Woods.jpg
run redshift
run picom
